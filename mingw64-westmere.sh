#!/bin/bash

make clean || echo clean

rm -f config.status
./autogen.sh || echo done

# icon
x86_64-w64-mingw32-windres res/icon.rc icon.o

# gcc 4.9.x/5.x only
CFLAGS="-O3 -march=westmere -Wall" CXXFLAGS="$CFLAGS -std=gnu++11 -fpermissive" LDFLAGS="icon.o -static" ./configure --with-curl

make

strip -p --strip-debug --strip-unneeded cpuminer.exe

if [ -e sign.sh ] ; then
. sign.sh
fi

mkdir -p deploy
mv cpuminer.exe deploy/cpuminer-opt-westmere.exe