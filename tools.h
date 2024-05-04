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

static inline uint32_t rol(uint32_t word, uint32_t shift){
	return (word<<shift) | (word >> (32 - shift));
}

static inline u32 cookie_gen(u32 src, u32 dst, u16 src_port, u16 dst_port)
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
	/*v3 = v3 ^ ntohl(seq_no);
	SIPROUND;
	SIPROUND;
	v0 = v0 ^ ntohl(seq_no); */
	
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

#endif