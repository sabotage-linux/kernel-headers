#!/bin/sh
test -z "$CC" && CC=cc
for x in test/*.c ; do
	printf "testing $(basename $x)..."
	$CC $x
	if test $? = 0 ; then
		echo OK
		rm a.out
	else
		echo FAIL
	fi
done
