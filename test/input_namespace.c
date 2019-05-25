#include <stdio.h>
#include <linux/input.h>

// 46140a4d4a93f5cee5d0e472c66027f81df62bcf

struct winsize {
	char dummy[16];
};
int main() {
	printf("%zu\n", sizeof(struct winsize));
}
