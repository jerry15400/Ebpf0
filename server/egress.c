#include"../tools.h"
#include"server.h"
#include<linux/pkt_cls.h>
#define IFINDEX 2  //?
#define IP_CSUM_OFF offsetof(struct iphdr,check)
#define IP_TOTLEN_OFF offsetof(struct iphdr,tot_len)

SEC("prog")
int tc_egress(struct __sk_buff *skb)
{
    void *data_end = (void *)(long)skb->data_end;
    void *data = (void *)(long)skb->data;
    struct ethhdr *eth = data;
    if(data+sizeof(*eth)>data_end) goto DROP;
    if(eth->h_proto!=htons(ETH_P_IP)) return TC_ACT_OK;
    struct iphdr *ip=data+sizeof(*eth);
    if(ip+sizeof(*ip)>data_end) goto DROP;
    if(ip->protocol==IPPROTO_UDP) return TC_ACT_OK;
    struct tcphdr *tcp=ip+sizeof(*ip);
    if(tcp+sizeof(*tcp)>data_end) goto DROP;
    map_key key;
    key_init(&key,ip->daddr,ip->saddr,tcp->dest,tcp->source);
    u32 *ptr=bpf_map_lookup_elem(&array_map,&key);
    u32 delta;
    if(ptr)
    {
        //should not happen
        goto DROP;
    }
    else
    {
        if(bpf_probe_read_kernel(&delta,sizeof(u32),ptr)!=0) return -1;
        u8 cksum_flags;
        if(tcp->ack&&tcp->syn)
        {
            swap(&ip->saddr,&ip->daddr,sizeof(u32));
            swap(&tcp->source,&tcp->dest,sizeof(u16));
            swap(eth->h_source,eth->h_dest,sizeof(eth->h_dest));
            tcp->syn=0;
            tcp->doff=0x5;  // doff*4-20 -> option len
            u32 pre_ack=tcp->ack_seq;  //x+1
            tcp->ack_seq=htonl(ntohl(tcp->seq)+1); //y+1
            tcp->seq=pre_ack;
            tcp->window=htons(0x1F6);
            delta=delta-ntohl(tcp->ack_seq);
            bpf_map_update_elem(&array_map,&key,&delta,BPF_ANY);
            tcp->check=eg_compute_full_tcp_checksum(ip,data+sizeof(*eth)+sizeof(*ip),data,data_end);
            uint16_t old_ip_len_n = ip->tot_len; 
			uint16_t new_ip_len_n = htons(0x28);
            if(bpf_l3_csum_replace(skb,sizeof(*eth)+IP_CSUM_OFF,old_ip_len_n,new_ip_len_n,sizeof(new_ip_len_n))<0) goto DROP;
            bpf_skb_store_bytes(skb,sizeof(*eth)+IP_TOTLEN_OFF,&new_ip_len_n,sizeof(new_ip_len_n),0);
            bpf_clone_redirect(skb,IFINDEX,BPF_F_INGRESS);
            void *data_end = (void *)(long)skb->data_end;
    		void *data = (void *)(long)skb->data;
    		if((data + 14 + 20 + 20)>data_end) goto DROP;
    		struct ethhdr *eth = data;
    		struct iphdr *ip = data + sizeof(*eth);
    		struct tcphdr *tcp = data + sizeof(*eth) + sizeof(*ip);
            cksum_flags=0x10;
            u16 *old_flags_ptr=data+sizeof(*eth)+sizeof(*ip)+12;
            u16 new_flags_n=htons(0x5040);
            if(bpf_l4_csum_replace(skb,sizeof(*eth)+sizeof(*ip)+16,*old_flags_ptr,new_flags_n,cksum_flags|sizeof(new_flags_n))<0) goto DROP;
            if(bpf_skb_store_bytes(skb,14+20+12,&new_flags_n,sizeof(new_flags_n),0)<0) goto DROP;
        }
        else
        {
            cksum_flags=BPF_F_PSEUDO_HDR;
            u32 new_seq=htonl(ntohl(tcp->seq)+delta);
            if(bpf_skb_store_bytes(skb,14+20+4,&new_seq,sizeof(new_seq),BPF_F_RECOMPUTE_CSUM)<0) goto DROP;
        }
        return TC_ACT_OK;
    }
    DROP:
    return TC_ACT_SHOT;
}

char _license[] SEC("license")="GPL";