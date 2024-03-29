#!/bin/bash
#
# nightly.sh
# start nighly build, then I can goto sleep
#
# Author: Alex.wang
# Create: 2012-11-22 22:34


function nightly () {
	[ -z "$1" ] && return

	echo remove old build
	rm -rf "$1/out/target/product/$1"

	echo start sync $1
	( cd $1 && repo sync -j1 )

	echo start build "$1"
	( cd $1 && . build/envsetup.sh && brunch $1 )
}


targets="$*"
[ -z "$targets" ] && targets="p350"
for target in $targets ; do
	nightly $target
done

