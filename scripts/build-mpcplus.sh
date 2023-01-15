#!/bin/bash
#
# Repo: https://github.com/doctorfree/mpcplus
#
# Fork of Repo: https://github.com/ncmpcpp/ncmpcpp
# Original Project: https://rybczak.net/ncmpcpp/
#
# To install original ncmpcpp:
# sudo apt install ncmpcpp
#
# To build and install mpcplus from source see the following
#
# Dependencies include:
# sudo apt install libboost
# sudo apt install libboost-all-dev
# sudo apt install libmpdclient-dev
# sudo apt install libcurl4-openssl-dev
# sudo apt install libfftw3-dev
# sudo apt install libtag1-dev
#
# Configure options include:
# --enable-artwork        Enable artwork screen [default=no]
# --enable-outputs        Enable outputs screen [default=no]
# --enable-visualizer     Enable music visualizer screen [default=no]
# --enable-clock          Enable clock screen [default=no]
#
# Usage: ./build-mpcplus.sh [-i]
# Where -i indicates install mpcplus after configuring and compiling

usage() {
    printf "\nUsage: ./build-mpcplus.sh [-aCiv] [-p prefix] [-u]"
    printf "\nWhere:"
    printf "\n\t-a indicates run autogen script and exit"
    printf "\n\t-C indicates run autogen, and configure and exit"
    printf "\n\t-i indicates configure, build, and install"
    printf "\n\t-v indicates configure with visualizer"
    printf "\n\t-p prefix specifies installation prefix (default /usr)"
    printf "\n\t-u displays this usage message and exits\n"
    printf "\nNo arguments: configure with prefix=/usr, no visualizer, build\n"
    exit 1
}

CONFIGURE_ONLY=
AUTOGEN_ONLY=
INSTALL=
PREFIX=
VISUAL="--disable-visualizer"
while getopts "aCip:uv" flag; do
    case $flag in
        a)
            AUTOGEN_ONLY=1
            ;;
        C)
            CONFIGURE_ONLY=1
            ;;
        i)
            INSTALL=1
            ;;
        v)
            VISUAL="--enable-visualizer --with-fftw"
            ;;
        p)
            PREFIX="$OPTARG"
            ;;
        u)
            usage
            ;;
    esac
done
shift $(( OPTIND - 1 ))

[ -x src/mpcplus ] && {
    echo "src/mpcplus already built"
    exit 0
}

[ -x ./configure ] || ./autogen.sh
[ "${AUTOGEN_ONLY}" ] && exit 0

prefix="--prefix=/usr"
[ "${PREFIX}" ] && prefix="--prefix=${PREFIX}"
./configure ${prefix} \
            --enable-artwork \
            --enable-static-boost \
            --enable-outputs \
            --enable-clock \
            ${VISUAL} \
            --with-taglib
[ "${CONFIGURE_ONLY}" ] && exit 0

make
scripts/relink-mpcplus.sh

WERR="-Wextra -Wshadow -Werror -Wno-error=deprecated-declarations"
CXXFLAGS="-O2 -march=native -pipe -std=c++0x ${WERR}"
make CXXFLAGS="${CXXFLAGS}" -C extras

if [ "${INSTALL}" ]
then
    sudo make install
fi
