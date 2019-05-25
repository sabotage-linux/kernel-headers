#include <netinet/in.h>
#include <linux/in6.h>

#include <stdio.h>
int main() {
	printf("%zu\n", sizeof(struct sockaddr_in6));
}
