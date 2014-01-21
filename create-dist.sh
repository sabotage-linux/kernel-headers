#!/bin/sh
if [ -z "$VER" ] ; then
	echo set VER!
	exit
fi
me=`pwd`

proj=kernel-headers
projver=${proj}-${VER}
repo="$me"

tempdir=/tmp/${proj}-0000
rm -rf $tempdir
mkdir -p $tempdir

cd $tempdir || { echo ERROR CDing ; exit 1 ; }
git clone $repo $projver
#(cd $projver ; git checkout v$VER )
rm -rf $projver/.git
rm -rf $projver/.gitignore
rm -rf $projver/docs
rm $projver/*.sh

tar cf $proj.tar $projver/
xz -z -9 -e -c < $proj.tar > $proj.tar.xz
mv $proj.tar.xz $me/$projver.tar.xz
echo done
