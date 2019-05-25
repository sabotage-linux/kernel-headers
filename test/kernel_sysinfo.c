#include <sys/sysinfo.h>
#include <linux/kernel.h>

#include <stdio.h>
int main() {
	printf("%zu\n", sizeof(struct sysinfo));
}
