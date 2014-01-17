#ifndef _ASM_X86_UNISTD_H
#define _ASM_X86_UNISTD_H 1

# ifdef __i386__
#  include <asm/unistd_32.h>
# else
#  include <asm/unistd_64.h>
# endif

#endif /* _ASM_X86_UNISTD_H */
