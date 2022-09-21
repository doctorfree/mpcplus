#!/bin/bash
#
# install-dev-env.sh - install or remove the build dependencies

arch=
centos=
debian=
fedora=
[ -f /etc/os-release ] && . /etc/os-release
[ "${ID_LIKE}" == "debian" ] && debian=1
[ "${ID}" == "arch" ] && arch=1
[ "${ID}" == "centos" ] && centos=1
[ "${ID}" == "fedora" ] && fedora=1
[ "${debian}" ] || [ -f /etc/debian_version ] && debian=1

if [ "${debian}" ]
then
  PKGS="build-essential libfftw3-dev libtag1-dev libmpdclient-dev \
        autotools-dev autoconf libtool libboost-all-dev fftw-dev \
        pkg-config libncurses-dev libreadline-dev libcurl4-openssl-dev \
        pandoc zip"
  if [ "$1" == "-r" ]
  then
    sudo apt remove ${PKGS}
  else
    sudo apt install ${PKGS}
  fi
else
  if [ "${arch}" ]
  then
    PKGS="base-devel fftw taglib libmpdclient boost boost-libs \
          ncurses readline libcurl-compat pandoc zip"
    RUN_PKGS="mpd fzf mpc"
    if [ "$1" == "-r" ]
    then
      sudo pacman -Rs ${RUN_PKGS}
    else
      sudo pacman -S --needed ${PKGS} ${RUN_PKGS}
    fi
  else
    have_dnf=`type -p dnf`
    if [ "${have_dnf}" ]
    then
      PINS=dnf
    else
      PINS=yum
    fi
    sudo ${PINS} makecache
    if [ "${fedora}" ]
    then
      PKGS="ncurses-devel fftw3-devel libtool automake pandoc zip \
            libmpdclient-devel taglib-devel"
      if [ "$1" == "-r" ]
      then
        sudo ${PINS} -y remove ${PKGS}
      else
        sudo ${PINS} -y groupinstall "Development Tools" "Development Libraries"
        sudo ${PINS} -y install gcc-c++
        sudo ${PINS} -y install ${PKGS}
      fi
    else
      if [ "${centos}" ]
      then
        PKGS="ncurses-devel fftw3-devel libtool automake libcurl-devel \
              boost-devel readline-devel pandoc zip libmpdclient-devel \
              taglib-devel"
        if [ "$1" == "-r" ]
        then
          sudo ${PINS} -y remove ${PKGS}
        else
          sudo ${PINS} -y groupinstall "Development Tools"
          sudo ${PINS} -y install gcc-c++
          sudo ${PINS} -y install ${PKGS}
        fi
      else
        echo "Unrecognized operating system"
      fi
    fi
  fi
fi
