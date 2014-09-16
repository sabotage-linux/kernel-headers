#!/bin/sh

# Note best to branch the repo first if updating to a new kernel

# first argument is kernel tree, you need to
# make allnoconfig
# make headers_install_all
# there first to get headers in $1/usr/include

if [ "$#" -ne 1 ] || ! [ -d "$1" ]; then
  echo "Usage: $0 KERNELTREE" >&2
  exit 1
fi

git rm -r generic/include/*
mkdir -p generic/include
for dir in arch asm-generic drm linux mtd rdma scsi sound uapi video xen
do
  cp -a $1/usr/include/$dir generic/include/
done

# these headers are missing from headers_install_all
cp -a $1/include/uapi/linux/{a.out,kvm,kvm_para}.h generic/include/linux/

find generic -name '..install.cmd' | xargs rm
find generic -name '.install' | xargs rm
git add generic/include/

for arch in arm powerpc mips x86 microblaze openrisc
do
  git rm -r $arch/include/*
  mkdir -p $arch/include
  for dir in arch asm-generic drm linux mtd rdma scsi sound uapi video xen
  do
    ln -s ../../generic/include/$dir $arch/include/$dir
  done
  cp -a $1/usr/include/asm-$arch $arch/include/asm
  find $arch -name '..install.cmd' | xargs rm
  find $arch -name '.install' | xargs rm
  git add $arch/include
done

