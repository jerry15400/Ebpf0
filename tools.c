#include"tools.h"


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
