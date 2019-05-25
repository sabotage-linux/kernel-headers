#include <linux/module.h>

#include <stdio.h>
int main() {
	printf("%d\n", MODULE_INIT_IGNORE_VERMAGIC);
}
