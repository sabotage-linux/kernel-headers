//#include <netinet/in.h>
#include <linux/if_bridge.h>

#include <stdio.h>
int main() {
	printf("%zu\n", sizeof(struct sockaddr_in6));
}
