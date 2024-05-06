#include"../tools.h"
#include"../bloom.h"
#define DEBUG 1

const int  MAX_ENTRY =100;


struct
{
    __uint(type,BPF_MAP_TYPE_HASH);
    __uint(max_entries,MAX_ENTRY);
    __type(key,u32);
    __type(value,u32);
}hash_map SEC(".maps");

SEC("prog")
int ingress(struct xdp_md *ctx)
{
    void *data=(void*)(long)ctx->data;
    void *data_end=(void*)(long)ctx->data_end;
    struct ethhdr *eth=data;
    if(data+sizeof(*eth)>data_end) return XDP_DROP;
    if(eth->h_proto!=htons(ETH_P_IP)) return XDP_PASS;
    struct iphdr *ip=data+sizeof(*eth);
    if(data+sizeof(*eth)+sizeof(*ip)>data_end) return XDP_DROP;
    if(ip->protocol!=IPPROTO_TCP) return XDP_PASS;
    struct tcphdr *tcp=data+sizeof(*eth)+sizeof(*ip);
    if(data+sizeof(*eth)+sizeof(*ip)+sizeof(*tcp)>data_end) return XDP_DROP;
    if(tcp->syn&&!tcp->ack)  //SYN->3WHS
    {
        if(DEBUG)
        {
            bpf_printk("Client SYN\n");
            bpf_printk("source ip: %d\n",ip->saddr);
            bpf_printk("dest ip: %d\n",ip->daddr);
            bpf_printk("source port: %d\n",tcp->source);
            bpf_printk("dest port: %d\n",tcp->dest);
        }
        u32 hash=cookie_gen(ip->saddr,ip->daddr,tcp->source,tcp->dest,tcp->seq);
        tcp->ack_seq=tcp->seq+1;
        tcp->seq=hash;
        swap(&tcp->source,&tcp->dest,sizeof(tcp->dest));
        swap(&ip->saddr,&ip->daddr,sizeof(ip->daddr));
        swap(eth->h_source,eth->h_dest,sizeof(eth->h_dest));
        u32 *flag_ptr=(void*)tcp+12;
        if((void*)flag_ptr+4>data_end) return XDP_DROP;
        u32 bflag=*flag_ptr;
        tcp->ack=1; // flag=0x18
        u32 aflag=*flag_ptr;
        u32 csum=tcp->check;
        csum=bpf_csum_diff(&bflag,4,&aflag,4,~csum);
        tcp->check=csum_fold_helper(csum);
        return XDP_TX;
    }
    else if(!tcp->syn&&tcp->ack) //ACK
    {
        u32 hash=cookie_gen(ip->saddr,ip->daddr,tcp->source,tcp->dest,tcp->seq-1);
        if(tcp->ack_seq==hash+1) //pass
        {
            if(DEBUG)
            {
                bpf_printk("Cookie pass\n");
                bpf_printk("ece flag= %d\n",tcp->ece);
            }
            bpf_map_update_elem(&hash_map,&hash,&tcp->seq,BPF_ANY);
            tcp->seq--;
            tcp->ece=1;
        }
        else
        {
            u32 seq,*ptr=bpf_map_lookup_elem(&hash_map,&hash);
            if(ptr)
            {
                bpf_probe_read_kernel(&seq,sizeof(u32),ptr);
                if(seq==tcp->seq) // signal from server TC to add BF
                {
                    bf_add(&bloom_filter,hash);
                    bpf_map_delete_elem(&hash_map,&hash);
                }
            }
            return XDP_DROP;
        }
        return XDP_PASS;
    }
    else
    {
        bpf_printk("Error\n");
        //if(bf_is_exist(&bloom_filter,hash)) return XDP_PASS;
    }
    return XDP_DROP;
}

char _license[] SEC("license")="GPL";