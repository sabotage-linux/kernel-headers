#!/bin/sh

# Note best to branch the repo first if updating to a new kernel

if [ "$#" -ne 1 ] || ! [ -d "$1" ]; then
  echo "Usage: $0 KERNELTREE" >&2
  exit 1
fi

for arch in arm powerpc mips x86_64
do
  git rm -r $arch/include/*
  mkdir -p $arch/include
  for dir in asm-generic drm linux rdma scsi sound video xen
  do
    cp -a $1/include/$dir $arch/include/
  done
  cp -a $1/arch/$arch/include/uapi/asm $arch/include/
done

