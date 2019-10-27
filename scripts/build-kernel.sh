#!/bin/sh 

#set -eax

##
## Build debian package of kernel.
##
## Environmental inputs:
##   CLEAN: if true, make clean first
##
## See https://www.maketecheasier.com/build-custom-kernel-ubuntu
##

## Steps to take:
##  1. Copy a recent config to ./.config
##  2. Run `make menuconfig`. If you're debugging this kernel, make sure debug 
##     symbols are enabled in the Kernel Hacking section
##  3. Clean out the old stuff if needed (by prepending CLEAN=1 to the next command)
##  4. Run this script as a normal user: `./build-kernel.sh`

## Build bugs:
##
## https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=862175
## Workaround: rm line 'make ... headers_install' from debian/ruleset/targets/headers.mk
##   whose template(?) is in /usr/share/kernel-package/ruleset/targets/headers.mk

#CUSTOM=--append-to-version=-cet # must start with '-', must have a corresponding rule to make the header files
#SOURCE=/source
SOURCE=.
VERSION=`make kernelversion`
export LOCALVERSION=-custom
export BUILDDIR=$VERSION$LOCALVERSION
#CLEAN=1

#threads=`grep 'model name' /proc/cpuinfo | wc -l`
#threads=$((`nproc`-1))
threads=`nproc --ignore=2`
export CONCURRENCY_LEVEL=$threads

build_check() {
    echo "Running $*"
    $*
    if [ $? -ne 0 ]; then
	exit 1
    fi
}

#sudo apt install install git build-essential kernel-package fakeroot libncurses5-dev libssl-dev ccache

cd $SOURCE

echo *** Read comments in this script before running! ***
echo Building kernel version $VERSION

# FIXME: recent kernels have moved a file; the build system can't find
# it so we link to the old location
# ---------------
#pushd Documentation/admin-guide
#ln -sf reporting-bugs.rst REPORTING-BUGS
#popd
#ln -f Documentation/admin-guide/reporting-bugs.rst .

if [ -n "$CLEAN" ]; then 
    echo Cleaning...
    build_check make-kpkg clean
fi

#build_check make -j $threads deb-pkg LOCALVERSION=$LOCALVERSION
#build_check fakeroot make-kpkg -j $threads --initrd deb-pkg LOCALVERSION=$LOCALVERSION
#build_check fakeroot make-kpkg -j $threads --initrd $CUSTOM kernel_image kernel_headers modules

build_check fakeroot make-kpkg -j $threads --initrd kernel_image kernel_headers
#build_check fakeroot make-kpkg -j $threads --initrd kernel_headers

build_check dpkg-deb --build debian/linux-image-$BUILDDIR
build_check dpkg-deb --build debian/linux-headers-$BUILDDIR

ls debian/*.deb
