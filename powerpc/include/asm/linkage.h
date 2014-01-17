#ifndef _ASM_POWERPC_LINKAGE_H
#define _ASM_POWERPC_LINKAGE_H

#ifdef CONFIG_PPC64
#define cond_syscall(x) \
	__asm__ ("\t.weak " #x "\n\t.set " #x ", sys_ni_syscall\n"		\
	     "\t.weak ." #x "\n\t.set ." #x ", .sys_ni_syscall\n")
#define SYSCALL_ALIAS(alias, name)					\
	__asm__ ("\t.globl " #alias "\n\t.set " #alias ", " #name "\n"	\
	     "\t.globl ." #alias "\n\t.set ." #alias ", ." #name)
#endif

#endif	/* _ASM_POWERPC_LINKAGE_H */
