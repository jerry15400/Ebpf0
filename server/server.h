#ifndef SERVER_H_INCLUDED
#define SERVER_H_INCLUDED

#include<stdint.h>
#include<linux/bpf.h>
#include<stdlib.h>
#include<bpf/bpf_helpers.h>

#define MAX_ENTRY 10000

typedef struct pkt_4tuple
{
	u32 saddr;
	u32 daddr;
	u16 src;
	u16 dest;
}map_key;


struct{
    __uint(type,BPF_MAP_TYPE_HASH);
    __uint(max_entries,MAX_ENTRY);
    __type(key,map_key);
    __type(value,u32);
    __uint(pinning,LIBBPF_PIN_BY_NAME);
}  array_map SEC(".maps") ;

static inline void key_init(map_key *key,u32 sa,u32 da,u16 s,u16 d)
{
	key->saddr=sa;
	key->daddr=da;
	key->src=s;
	key->dest=d;
}

static inline unsigned short compute_ip_checksum(struct iphdr *ip, unsigned short *ipSeg, void *data_start, void *data_end){
    register unsigned long sum = 0;
    unsigned short ipLen = ip->ihl<<2;
    unsigned int i;
    //max size of ip header is 60 bytes, with options and padding
    //for now assume no options needed and just calculate over first 20 bytes  
    unsigned int j = 10;
    for (i = 0; i < j; i++) {

                //ensure pointer doesn't go outside of data_end and data_start (outside of packet) 
                if(ipSeg + 1 > (uint16_t *)data_end || ipSeg < (uint16_t *)data_start){
                break;
                }
                //only add if not pointing to checksum (at 6th 16-bit word)   
                if(i != 5){
                sum += * ipSeg;
                }
        //increment pointer to next 16 bits of tcp segment 
        ipSeg++;
        ipLen -= 2;
	}
	//if any bytes left within packet boundaries, pad the bytes and add
        if(ipLen != 0 && (ipSeg + 1 <= (uint16_t *)data_end) && (ipSeg >= (uint16_t *)data_start)) {
        uint8_t upper_byte = (uint8_t) *ipSeg;
        uint16_t padded_bytes = ((uint16_t)upper_byte)<<8;
        sum += padded_bytes;
        //sum += ((*tcpSeg)&htons(0xFF00));
        }
        //Fold 32-bit sum to 16 bits: add carrier to result     
        //TODO: make sure checksum is correct, optimize this for loop? 
        for(i = 0; i < j; i++){
                if(sum>>16){
                        sum = (sum & 0xffff) + (sum >> 16);
                }
        }
  /*    while (sum>>16) {
          sum = (sum & 0xffff) + (sum >> 16);
      }
    */
        sum = ~sum;
    return sum;

}

/* set tcp checksum: given IP header and tcp segment */
static inline unsigned short eg_compute_full_tcp_checksum(struct iphdr *ip, unsigned short *tcpSeg, void *data_start, void * data_end) {
    register unsigned long sum = 0;
    //hardcode tcpLen since this function is only used for tcpLen = 20 
    unsigned short tcpLen = 0x14;	
    //    unsigned short tcpLen = ntohs(ip->tot_len) - (ip->ihl<<2);
    //add the pseudo header
    //the source ip
    sum += (ip->saddr>>16)&0xFFFF;
    sum += (ip->saddr)&0xFFFF;
    //the dest ip
    sum += (ip->daddr>>16)&0xFFFF;
    sum += (ip->daddr)&0xFFFF;
    //protocol and reserved: 6
    sum += htons(IPPROTO_TCP);
    //the length
    sum += htons(tcpLen);

        unsigned int i;
        //max tcp hdr bytes is 60, so 30 16-bit words 
        //for now set some large size to get max tcp data bytes 
        unsigned int j = 200;
        //add tcp header, options, data 
        for (i = 0; i < j; i++) {
                 //ensure pointer doesn't go outside of data_end and data_start (outside of packet) 
                if(tcpSeg + 1 > (uint16_t *)data_end || tcpSeg < (uint16_t *)data_start){
                break;
                }
                if(tcpLen <= 0){
                        break;
                }
                //check if pointing to checksum, then don't add  
                if(i != 8){
                sum += * tcpSeg;
                }
        //increment pointer to next 16 bits of tcp segment 
        tcpSeg++;
        tcpLen -= 2;

         }

        //if any bytes left within packet boundaries, pad the bytes and add
        if(tcpLen != 0 && (tcpSeg + 1 <= (uint16_t *)data_end) && (tcpSeg >= (uint16_t *)data_start)) {
        uint8_t upper_byte = (uint8_t) *tcpSeg;
        uint16_t padded_bytes = ((uint16_t)upper_byte)<<8;
        sum += padded_bytes;
        //sum += ((*tcpSeg)&htons(0xFF00));
        }

        //Fold 32-bit sum to 16 bits: add carrier to result
        //TODO: make sure checksum is correct, optimize this for loop?
        for(i = 0; i < j; i++){
                if(sum>>16){
                        sum = (sum & 0xffff) + (sum >> 16);
                }
        }

    sum = ~sum;
    return sum;
}

/* INCREMENTAL tcp checksum updatet */
static unsigned short compute_incr_tcp_checksum(unsigned short old_checksum, unsigned short old_val, unsigned short new_val) {
    // Formula from RFC1624 is HC' = ~(C + (-m) + m')
    // where HC - old checksum in header   
    // C - one's complement sum of old header
    // HC' - new checksum in header
    // C' - one's complement sum of new header
    // m - old value of a 16-bit field
    // m' - new value of a 16-bit field
    //take 1, slightly off, probably not handling carry 
    //return ~( (~old_checksum) - old_val + new_val );
    //take 2, this works, should figure out how to optimize the for loop 
    unsigned long new_checksum = ( (~old_checksum&0xFFFF) - old_val + new_val );
    if(new_checksum>>16){
          new_checksum = (new_checksum & 0xffff) + (new_checksum >> 16);
    }
    /*
    int i = 0; 
    int j = 100; 
    //Fold 32-bit sum to 16 bits: add carrier to result
    //TODO: make sure checksum is correct, optimize this for loop?
    for(i = 0; i < j; i++){
           if(new_checksum>>16){
                   new_checksum = (new_checksum & 0xffff) + (new_checksum >> 16);
           }
    }
    */
    return ~new_checksum; 
}

#endif