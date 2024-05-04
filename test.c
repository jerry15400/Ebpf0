#include<stdio.h>
#define ll long long
void swap(void *a,void *b,ll size)
{
    unsigned char tmp;
    unsigned char *p=a,*q=b;
    for(ll i=0;i<size;i++)
    {
        tmp=p[i];
        p[i]=q[i];
        q[i]=tmp;
    }
}

int main()
{
    int a[6],b[6];
    for(int i=0;i<6;i++)
    {
        a[i]=i;
        b[i]=6-i;
    }
    swap(a,b,sizeof(unsigned));
    for(int i=0;i<6;i++)
    {
        printf("%d %d\n",a[i],b[i]);
    }
    return 0;
}