#ifndef BLOOM_H_INCLUDED
#define BLOOM_H_INCLUDED

#include<stdint.h>
#include<stdlib.h>
#include<linux/bpf.h>
#include<bpf/bpf_helpers.h>


const int MAX_INT=4096;
const int total_bit=MAX_INT*32;

typedef struct bloom_filter
{
	int *bitmap;
	int total_bits;
}Bloom_Filter;

struct{
    __uint(type,BPF_MAP_TYPE_ARRAY);
    __uint(max_entries,MAX_INT);
	__type(key,uint32_t);
    __type(value,uint32_t);
} bloom_filter SEC(".maps");

/*void bf_init(Bloom_Filter*,uint32_t);
void bf_add(Bloom_Filter*,uint32_t);
void bf_set(Bloom_Filter*,int,int);
int bf_is_exitst(Bloom_Filter*,uint32_t);*/

/*static inline void bf_add(void*,uint32_t);
static inline void bf_set(void*,int,int);
static inline int bf_is_exist(void*,uint32_t);

static inline uint32_t Murmur(uint32_t);
static inline uint32_t Jenkins(uint32_t);*/


static inline uint32_t Murmur(uint32_t key)
{
    const uint32_t m = 0x5bd1e995;
    const int r = 24;

    uint32_t h = 0;

    //uint8_t *data = (uint8_t *)&key;

    uint32_t k = key;

    k *= m;
    k ^= k >> r;
    k *= m;

    h *= m;
    h ^= k;

    h ^= h >> 13;
    h *= m;
    h ^= h >> 15;

    return h;
}

uint32_t Jenkins(uint32_t key)
{
    uint32_t hash = key;
    hash += (hash << 10);
    hash ^= (hash >> 6);
    hash += (hash << 3);
    hash ^= (hash >> 11);
    hash += (hash << 15);
    return hash;
}

static inline void bf_set(void *bf,int index,int offset)
{
    uint32_t val,*ptr=bpf_map_lookup_elem(bf,&index);
    bpf_probe_read_kernel(&val,sizeof(uint32_t),ptr);
    val|=(1<<offset);
    bpf_map_update_elem(bf,&index,&val,BPF_ANY);
}


static inline void bf_add(void *bf,uint32_t e)
{
    uint32_t h1=Murmur(e)%total_bit,h2=Jenkins(e)%total_bit;
    bf_set(bf,h1/32,h1%32);
    bf_set(bf,h2/32,h2%32);
}


static inline int bf_is_exist(void *bf,uint32_t e)
{
    uint32_t h1=Murmur(e)%total_bit,h2=Jenkins(e)%total_bit;
    uint32_t i1=h1/32,i2=h2/32;
    uint32_t v1,v2,*p1=bpf_map_lookup_elem(bf,&i1),*p2=bpf_map_lookup_elem(bf,&i2);
    if(p1&&p2)
    {
        bpf_probe_read_kernel(&v1,sizeof(uint32_t),p1);
        bpf_probe_read_kernel(&v2,sizeof(uint32_t),p2);
        return (v1&(1<<(h1%32)))&&(v2&(1<<(h2%32)));
    }
    return 0;
}



#endif