#!/bin/sh

# Note best to branch the repo first if updating to a new kernel

# first argument is kernel tree, e.g. ../linux-6.12.77

if [ "$#" -ne 1 ] || ! [ -d "$1" ]; then
  echo "Usage: $0 KERNELTREE" >&2
  exit 1
fi

# put x86 at the end so kernel doesnt remove some headers it deems gratuitous
ARCHS="$(ls -1 "$1"/arch | grep -v Kconfig | grep -v um | grep -v x86) x86"
OLDPWD=$(pwd)

cd "$1" && rm -rf usr/include
make allnoconfig
for arch in $ARCHS ; do
 make headers_install ARCH=$arch
 mv usr/include/asm usr/include/asm-$arch
done
find usr/include -name '*.cmd' -delete
cd "$OLDPWD"

git rm -rf generic/include/*
mkdir -p generic/include
for dir in asm-generic drm linux mtd misc rdma regulator scsi sound video xen
do
  if test -d "$1"/usr/include/$dir ; then
    cp -RP "$1"/usr/include/$dir generic/include/
  else
    echo "warning: skipping $dir"
  fi
done

# these headers are missing from headers_install
#(cd "$1"
#for i in a.out.h kvm.h kvm_para.h module.h ; do
#scripts/headers_install.sh include/uapi/linux/$i \
#  "$OLDPWD"/generic/include/linux/$i
#)

find generic -name '..install.cmd' -delete
find generic -name '.install' -delete

git add generic/include/

for arch in $ARCHS
do
  test -e $arch/include && git rm -rf $arch/include/*
  mkdir -p $arch/include
  for dir in arch asm-generic drm linux mtd rdma scsi sound video xen
  do
    test -d generic/include/$dir && \
      ln -s ../../generic/include/$dir $arch/include/$dir
  done
  if test -d $1/usr/include/asm-$arch ; then
    cp -RP $1/usr/include/asm-$arch $arch/include/asm
  else
    cp -RP $1/usr/include/arch-$arch/asm $arch/include/
  fi
  find $arch -name '..install.cmd' -delete
  find $arch -name '.install' -delete
  git add $arch/include
done
