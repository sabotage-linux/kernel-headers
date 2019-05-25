#include <sys/ptrace.h>
#include <linux/ptrace.h>

#include <stdio.h>
int main() {
	printf("%zu\n", sizeof(struct pt_regs));
}
