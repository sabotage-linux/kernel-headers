#include <netinet/tcp.h>
#include <linux/tcp.h>

#include <stdio.h>
int main() {
	printf("%zu\n", sizeof(struct tcphdr));
}
