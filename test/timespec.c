#define _GNU_SOURCE
#include <time.h>
#include <sys/time.h>
#include <linux/time.h>

#include <stdio.h>
int main() {
	printf("%zu\n", sizeof(struct timespec));
}
