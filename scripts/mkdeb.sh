#!/bin/bash
PKG="mpcplus"
SRC_NAME="mpcplus"
PKG_NAME="mpcplus"
DEBFULLNAME="Ronald Record"
DEBEMAIL="ronaldrecord@gmail.com"
DESTDIR="usr"
SRC=${HOME}/src
ARCH=amd64
SUDO=sudo
GCI=

dpkg=`type -p dpkg-deb`
[ "${dpkg}" ] || {
    echo "Debian packaging tools do not appear to be installed on this system"
    echo "Are you on the appropriate Linux system with packaging requirements ?"
    echo "Exiting"
    exit 1
}
dpkg_arch=`dpkg --print-architecture`
[ "${dpkg_arch}" == "${ARCH}" ] || ARCH=${dpkg_arch}

[ -f "${SRC}/${SRC_NAME}/VERSION" ] || {
  [ -f "/builds/doctorfree/${SRC_NAME}/VERSION" ] || {
    echo "$SRC/$SRC_NAME/VERSION does not exist. Exiting."
    exit 1
  }
  SRC="/builds/doctorfree"
  GCI=1
# SUDO=
}

. "${SRC}/${SRC_NAME}/VERSION"
PKG_VER=${VERSION}
PKG_REL=${RELEASE}

umask 0022

# Subdirectory in which to create the distribution files
OUT_DIR="dist/${PKG_NAME}_${PKG_VER}"

[ -d "${SRC}/${SRC_NAME}" ] || {
    echo "$SRC/$SRC_NAME does not exist or is not a directory. Exiting."
    exit 1
}

cd "${SRC}/${SRC_NAME}"

# Build mpcplus
if [ -x scripts/build-mpcplus.sh ]
then
  scripts/build-mpcplus.sh -v
else
  make clean
  make distclean
  [ -x ./configure ] || ./autogen.sh > /dev/null
  ./configure --prefix=/usr \
              --enable-outputs \
              --enable-clock \
              --enable-visualizer \
              --with-fftw \
              --with-taglib > configure$$.out
  make > make$$.out
fi

${SUDO} rm -rf dist
mkdir dist

[ -d ${OUT_DIR} ] && rm -rf ${OUT_DIR}
mkdir ${OUT_DIR}
cp -a pkg/debian ${OUT_DIR}/DEBIAN
chmod 755 ${OUT_DIR} ${OUT_DIR}/DEBIAN ${OUT_DIR}/DEBIAN/*

echo "Package: ${PKG}
Version: ${PKG_VER}-${PKG_REL}
Section: sound
Priority: optional
Architecture: ${ARCH}
Depends: libboost-all-dev (>= 1.71.0), libcurl4 (>= 7.68.0), libmpdclient2 (>= 2.9), libncursesw6 (>= 6), libreadline8 (>= 6.0), libtag1v5 (>= 1.11), mpc, libfftw3-dev, libcurl4-openssl-dev
Maintainer: ${DEBFULLNAME} <${DEBEMAIL}>
Installed-Size: 3000
Build-Depends: debhelper (>= 11)
Provides: mpcplus-completion, mpd-client
Suggests: desktop-file-utils
Homepage: https://github.com/doctorfree/mpcplus
Description: Music Player Daemon Client Plus
 NCurses-based client for the Music Player Daemon (MPD)
 mpcplus is a clone of ncmpcpp which is a text-mode client for MPD,
 the Music Player Daemon. It provides a keyboard oriented and consistent
 interface to MPD and contains some new features ncmpcpp doesn't have.
 .
 New features include:
  - tag editor;
  - playlists editor;
  - easy to use search screen;
  - media library screen;
  - lyrics screen;
  - possibility of going to any position in currently playing track
    without rewinding/fastforwarding;
  - multi colored main window (if you want);
  - songs can be added to playlist more than once;
  - a lot of minor useful functions." > ${OUT_DIR}/DEBIAN/control

chmod 644 ${OUT_DIR}/DEBIAN/control

for dir in "${DESTDIR}" "${DESTDIR}/share" "${DESTDIR}/share/man" \
           "${DESTDIR}/share/applications" "${DESTDIR}/share/doc" \
           "${DESTDIR}/share/doc/${PKG}" "${DESTDIR}/share/${PKG}"
do
    [ -d ${OUT_DIR}/${dir} ] || ${SUDO} mkdir ${OUT_DIR}/${dir}
    ${SUDO} chown root:root ${OUT_DIR}/${dir}
done

for dir in bin
do
    [ -d ${OUT_DIR}/${DESTDIR}/${dir} ] && ${SUDO} rm -rf ${OUT_DIR}/${DESTDIR}/${dir}
done

${SUDO} cp -a bin ${OUT_DIR}/${DESTDIR}/bin
${SUDO} cp src/mpcplus ${OUT_DIR}/${DESTDIR}/bin/mpcplus
${SUDO} cp extras/artist_to_albumartist \
           ${OUT_DIR}/${DESTDIR}/bin/artist_to_albumartist
${SUDO} cp *.desktop "${OUT_DIR}/${DESTDIR}/share/applications"
${SUDO} cp copyright ${OUT_DIR}/${DESTDIR}/share/doc/${PKG}
${SUDO} cp NOTICE ${OUT_DIR}/${DESTDIR}/share/doc/${PKG}
${SUDO} cp AUTHORS ${OUT_DIR}/${DESTDIR}/share/doc/${PKG}
${SUDO} cp CHANGELOG.md ${OUT_DIR}/${DESTDIR}/share/doc/${PKG}
${SUDO} cp COPYING ${OUT_DIR}/${DESTDIR}/share/doc/${PKG}
${SUDO} cp README.md ${OUT_DIR}/${DESTDIR}/share/doc/${PKG}
${SUDO} pandoc -f gfm README.md | ${SUDO} tee ${OUT_DIR}/${DESTDIR}/share/doc/${PKG}/README.html > /dev/null
${SUDO} gzip -9 ${OUT_DIR}/${DESTDIR}/share/doc/${PKG}/CHANGELOG.md

${SUDO} cp doc/config ${OUT_DIR}/${DESTDIR}/share/${PKG}
${SUDO} cp doc/bindings ${OUT_DIR}/${DESTDIR}/share/${PKG}
${SUDO} cp share/mpcplus-cheat-sheet.txt ${OUT_DIR}/${DESTDIR}/share/${PKG}
${SUDO} cp share/mpcplus-cheat-sheet.md ${OUT_DIR}/${DESTDIR}/share/${PKG}

${SUDO} cp -a share/scripts ${OUT_DIR}/${DESTDIR}/share/${PKG}/scripts

${SUDO} cp -a man/man1 ${OUT_DIR}/${DESTDIR}/share/man/man1
${SUDO} cp -a share/menu "${OUT_DIR}/${DESTDIR}/share/menu"

[ -f .gitignore ] && {
    while read ignore
    do
        ${SUDO} rm -f ${OUT_DIR}/${DESTDIR}/${ignore}
    done < .gitignore
}

${SUDO} chmod 644 ${OUT_DIR}/${DESTDIR}/share/man/*/*
${SUDO} chmod 644 ${OUT_DIR}/${DESTDIR}/share/menu/*
${SUDO} chmod 755 ${OUT_DIR}/${DESTDIR}/bin/* \
                  ${OUT_DIR}/${DESTDIR}/bin \
                  ${OUT_DIR}/${DESTDIR}/share/man \
                  ${OUT_DIR}/${DESTDIR}/share/man/* \
                  ${OUT_DIR}/${DESTDIR}/share/${PKG}/scripts/*
${SUDO} chown -R root:root ${OUT_DIR}/${DESTDIR}

cd dist
echo "Building ${PKG_NAME}_${PKG_VER} Debian package"
${SUDO} dpkg --build ${PKG_NAME}_${PKG_VER} ${PKG_NAME}_${PKG_VER}-${PKG_REL}.${ARCH}.deb
cd ${PKG_NAME}_${PKG_VER}
echo "Creating compressed tar archive of ${PKG_NAME} ${PKG_VER} distribution"
tar cf - usr | gzip -9 > ../${PKG_NAME}_${PKG_VER}-${PKG_REL}.tgz

have_zip=`type -p zip`
[ "${have_zip}" ] || {
  ${SUDO} apt-get update
  ${SUDO} apt-get install zip -y
}
echo "Creating zip archive of ${PKG_NAME} ${PKG_VER} distribution"
zip -q -r ../${PKG_NAME}_${PKG_VER}-${PKG_REL}.zip usr

cd ..
[ "${GCI}" ] || {
    [ -d ../releases ] || mkdir ../releases
    [ -d ../releases/${PKG_VER} ] || mkdir ../releases/${PKG_VER}
    ${SUDO} cp *.deb *.tgz *.zip ../releases/${PKG_VER}
}
