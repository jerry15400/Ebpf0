#ifndef TOOLS_H_INCLUDED
#define TOOLS_H_INCLUDED

#include <linux/bpf.h>
#include <arpa/inet.h>
#include <linux/in.h>
#include <linux/if_ether.h>
#include <linux/if_packet.h>
#include <linux/if_vlan.h>
#include <linux/ip.h>
#include <linux/ipv6.h>
#include <linux/tcp.h>
#include <linux/udp.h>
#include <bpf/bpf_helpers.h>

#define u64 unsigned long long
#define u32 unsigned int
#define u16 unsigned short int
#define u8 unsigned char
#define INT_BIT 32


//static inline uint32_t rol(uint32_t, uint32_t);


#define SIPROUND \
	do { \
	v0 += v1; v2 += v3; v1 = rol(v1, 5); v3 = rol(v3,8); \
	v1 ^= v0; v3 ^= v2; v0 = rol(v0, 16); \
	v2 += v1; v0 += v3; v1 = rol(v1, 13); v3 = rol(v3, 7); \
	v1 ^= v2; v3 ^= v0; v2 = rol(v2, 16); \
	} while (0)

/*static inline u32 left_rotate_shift(u32,u32);
static inline u32 cookie_gen(u32,u32,u16,u16);
static inline void swap(void*,void*,u64);*/


const int key0 = 0x33323130;
const int key1 = 0x42413938;
const int c0 = 0x70736575;
const int c1 = 0x6e646f6d;
const int c2 = 0x6e657261;
const int c3 = 0x79746573;

typedef struct pkt6tuple
{
	u32 saddr;
	u32 daddr;
	u16 source;
	u16 dest;
	u32 seq;
	u32 ack_seq;
}pkt6Tuple;

static __always_inline void init_pkt(pkt6Tuple *pkt,struct tcphdr *tcp,struct iphdr *ip)
{
	pkt->saddr=ntohl(ip->saddr);
	pkt->daddr=ntohl(ip->daddr);
	pkt->source=ntohs(tcp->source);
	pkt->dest=ntohs(tcp->dest);
	pkt->seq=ntohl(tcp->seq);
	pkt->ack_seq=ntohl(tcp->ack_seq);
}

static __always_inline void set_pkt(pkt6Tuple *pkt,struct tcphdr *tcp,struct iphdr *ip)
{
	ip->saddr=htonl(pkt->saddr);
	ip->daddr=htonl(pkt->daddr);
	tcp->source=htons(pkt->source);
	tcp->dest=htons(pkt->dest);
	tcp->seq=htonl(pkt->seq);
	tcp->ack_seq=htonl(pkt->ack_seq);
}


static inline uint32_t rol(uint32_t word, uint32_t shift){
	return (word<<shift) | (word >> (32 - shift));
}

static inline u32 cookie_gen(u32 src, u32 dst, u16 src_port, u16 dst_port,u32 seq_no)
{	
	//initialization 
	int v0 = c0 ^ key0;
	int v1 = c1 ^ key1;
	int v2 = c2 ^ key0;
	int v3 = c3 ^ key1; 
	
	//first message 
	v3 = v3 ^ ntohl(src);
	SIPROUND;
	SIPROUND;
	v0 = v0 ^ ntohl(src); 

	//second message 
	v3 = v3 ^ ntohl(dst);
	SIPROUND;
	SIPROUND;
	v0 = v0 ^ ntohl(dst); 

	//third message
	u32 ports = (u32) dst_port << 16 | (u32) src_port;  
	v3 = v3 ^ ntohl(ports);
	SIPROUND;
	SIPROUND;
	v0 = v0 ^ ntohl(ports); 

	//fourth message 
	v3 = v3 ^ ntohl(seq_no);
	SIPROUND;
	SIPROUND;
	v0 = v0 ^ ntohl(seq_no);
	
	//finalization
	v2 = v2 ^ 0xFF; 
	SIPROUND;
	SIPROUND;
	SIPROUND;
	SIPROUND;

	u32 hash = (v0^v1)^(v2^v3);
    return hash; 	
}

static inline void swap(void *a,void *b,u64 size)
{
    unsigned char tmp;
    unsigned char *p=a,*q=b;
    for(u64 i=0;i<size;i++)
    {
        tmp=p[i];
        p[i]=q[i];
        q[i]=tmp;
    }
}

static __always_inline u16 csum_fold_helper(u64 csum)
{
    for(int i=0;i<4;i++)
    {
        if(csum>>16) csum=(csum&0xffff)+(csum>>16);
    }
    return ~csum;
}

#endif