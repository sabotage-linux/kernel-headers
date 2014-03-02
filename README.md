sabotage's linux kernel headers
===============================

linux headers are often broken for userspace, and downloading
the entire kernel tarball just to get the headers is overkill.

thus we provide our own copy for the archs supported by sabotage.

some minor issues are fixed, plus libc-compat.h is patched
to offer the same level of support for musl libc as the vanilla
headers offer for glibc.

we currently use the headers of kernel 3.12.6, which is what
Debian is now using. There is a previous 3.3.4 branch.

Installation:
-------------

    make ARCH=xxx prefix=/usr DESTDIR=/opt/package install

where ARCH is the name of one of the arch-specific directories.
for example, i386, x86_64, x32, powerpc, mips, microblaze.

Download mirrors for release tarballs:
--------------------------------------

- DE : http://ftp.barfooze.de/pub/sabotage/tarballs/
- GR : http://foss.aueb.gr/mirrors/linux/sabotage/tarballs/
- UK : http://dl.2f30.org/mirrors/sabotage/tarballs/


Adding a new arch:
------------------

    export ARCH=xxx
    tar xf linux-3.12.6.tar.xz && cd linux-3.12.6
    CC=false make V=1 ARCH=$ARCH INSTALL_HDR_PATH=dest headers_install
    rm dest/include/asm/.*install*
    cd ..
    cp -r sh $ARCH
    rm -rf $ARCH/include/asm
    cp -r linux-3.12.6/dest/include/asm $ARCH/include
    rm -rf linux-3.12.6

