#include <netinet/if_ether.h>
#include <linux/tcp.h>

#include <stdio.h>
int main() {
	printf("%zu\n", sizeof(struct ethhdr));
}
