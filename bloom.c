#include"bloom.h"

/*void bf_init(Bloom_Filter *bf,uint32_t size)
{
    bf->total_bits=size;
    bf->bitmap=(int*)calloc(size/32+1,sizeof(int));
}

void bf_set(Bloom_Filter *bf,int index,int offset)
{
    bf->bitmap[index]|=(1<<offset);
}

void bf_add(Bloom_Filter *bf,uint32_t e)
{
    uint32_t h1=Murmur(e)%bf->total_bits,h2=Jenkins(e)%bf->total_bits;
    bf_set(bf,h1/32,h1%32);
    bf_set(bf,h2/32,h2%32);
}

int bf_is_exist(Bloom_Filter *bf,uint32_t e)
{
    uint32_t h1=Murmur(e)%bf->total_bits,h2=Jenkins(e)%bf->total_bits;
    return (bf->bitmap[h1/32]&(1<<(h1%32)))&&(bf->bitmap[h2/32]&(1<<(h2%32)));
}*/

static inline void bf_add(void *bf,uint32_t e)
{
    uint32_t h1=Murmur(e)%total_bit,h2=Jenkins(e)%total_bit;
    bf_set(bf,h1/32,h1%32);
    bf_set(bf,h2/32,h2%32);
}

static inline void bf_set(void *bf,int index,int offset)
{
    uint32_t val,*ptr=bpf_map_lookup_elem(bf,&index);
    bpf_probe_read_kernel(&val,sizeof(uint32_t),ptr);
    val|=(1<<offset);
    bpf_map_update_elem(bf,&index,&val,BPF_ANY);
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