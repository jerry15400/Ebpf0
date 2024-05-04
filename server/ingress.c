#include"../tools.h"
#include"server.h"


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
    map_key key;
    key_init(&key,ip->saddr,ip->daddr,tcp->source,tcp->dest);
    u32 *ptr=bpf_map_lookup_elem(&array_map,&key);
    u32 delta,pre_ack=tcp->ack_seq;
    if(ptr)  //connection exists
    {
        if(bpf_probe_read_kernel(&delta,sizeof(u32),ptr)!=0) return -1;
        tcp->ack_seq=htonl(ntohl(tcp->ack_seq)-delta);
        /*tcp->check=compute_incr_tcp_checksum(tcp->check,(u16)(pre_ack&0xFFFF),(u16)tcp->ack_seq&0xFFFF);
        tcp->check=compute_incr_tcp_checksum(tcp->check,(u16)((pre_ack>>16)&0xFFFF),(u16)((tcp->ack_seq>>16)&0xFFFF));*/
    }
    else //handshake
    {
        delta=ntohl(tcp->ack_seq);
        bpf_map_update_elem(&array_map,&key,&delta,BPF_ANY);
        tcp->ack_seq=0;
        /*tcp->check=compute_incr_tcp_checksum(tcp->check,(u16)(pre_ack&0xFFFF),(u16)tcp->ack_seq&0xFFFF);
        tcp->check=compute_incr_tcp_checksum(tcp->check,(u16)((pre_ack>>16)&0xFFFF),(u16)((tcp->ack_seq>>16)&0xFFFF));*/
        uint16_t* casted_ptr=(uint16_t*) tcp;
        uint16_t old_flags_n = casted_ptr[6];
        tcp->ack=0;
        tcp->syn=1;
        //tcp->ece=0;
        u16 new_flags_n = casted_ptr[6];
        //tcp->check = compute_incr_tcp_checksum(tcp->check,old_flags_n, new_flags_n);
    }
    return XDP_PASS;
}

char _license[] SEC("license")="GPL";