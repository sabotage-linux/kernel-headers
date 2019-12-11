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

cp generic/include/linux/module.h module.h.tmp

git rm -rf generic/include/*
mkdir -p generic/include
for dir in asm-generic drm linux mtd rdma scsi sound video xen
do
  if test -d $1/usr/include/$dir ; then
    cp -RP $1/usr/include/$dir generic/include/
  else
    echo "warning: skipping $dir"
  fi
done

uapi_base=
test -d $1/usr/include/uapi && uapi_base=uapi/
# these headers are missing from headers_install_all
cp -RP $1/include/${uapi_base}linux/{a.out,kvm,kvm_para,module}.h generic/include/linux/

test -e generic/include/linux/module.h || \
  mv module.h.tmp generic/include/linux/module.h

find generic -name '..install.cmd' -exec rm {} +
find generic -name '.install' -exec rm {} +
git add generic/include/

for arch in arm arm64 powerpc mips x86 microblaze openrisc sh
do
  git rm -rf $arch/include/*
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
  find $arch -name '..install.cmd' -exec rm {} +
  find $arch -name '.install' -exec rm {} +
  git add $arch/include
done
