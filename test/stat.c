#include <sys/stat.h>
#include <linux/stat.h>

#include <stdio.h>
int main() {
	printf("%zu\n", sizeof(struct stat));
}
