#include"../tools.h"
#include"../bloom.h"

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
    if(eth+sizeof(*eth)>data_end) return XDP_DROP;
    if(eth->h_proto!=htons(ETH_P_IP)) return XDP_PASS;
    struct iphdr *ip=data+sizeof(*eth);
    if(ip+sizeof(*ip)>data_end) return XDP_DROP;
    if(ip->protocol==IPPROTO_UDP) return XDP_PASS;
    struct tcphdr *tcp=ip+sizeof(*ip);
    if(tcp+sizeof(*tcp)>data_end) return XDP_DROP;
    u32 hash=cookie_gen(ip->saddr,ip->daddr,tcp->source,tcp->dest);
    if(tcp->syn&&!tcp->ack)  //SYN->3WHS
    {
        tcp->ack_seq=tcp->seq;
        tcp->seq=hash;
        swap(&tcp->source,&tcp->dest,sizeof(tcp->dest));
        swap(&ip->saddr,&ip->daddr,sizeof(ip->daddr));
        swap(eth->h_source,eth->h_dest,sizeof(eth->h_dest));
        tcp->ack=1,tcp->psh=1; // flag=0x18
        return XDP_REDIRECT;
    }
    else if(!tcp->syn&&tcp->ack) //ACK
    {
        if(tcp->ack_seq==hash+1) //pass
        {
            bpf_map_update_elem(&hash_map,&hash,&tcp->seq,BPF_ANY);
            tcp->seq--;
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
        if(bf_is_exist(&bloom_filter,hash)) return XDP_PASS;
    }
    return XDP_DROP;
}

char _license[] SEC("license")="GPL";