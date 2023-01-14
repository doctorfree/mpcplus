[Mpcplus](https://github.com/doctorfree/mpcplus#readme) is an open source NCurses character-based Music Player Daemon (MPD) client inspired by `ncmpcpp`. The `mpcplus` MPD client is customized for integration with the [MusicPlayerPlus project](https://github.com/doctorfree/MusicPlayerPlus#readme) and the [Mppcava spectrum visualizer](https://github.com/doctorfree/mppcava#readme).

**[Important Note:]** This initial release of the `mpcplus` package is intended to serve as a test release for future integration with `MusicPlayerPlus`. Although it is a fully featured `mpcplus`, MusicPlayerPlus integration is still in development and will not be available until MusicPlayerPlus version 3 is released. To get the fully integrated features of `mpcplus` at this time, install [MusicPlayerPlus version 2](https://github.com/doctorfree/MusicPlayerPlus/releases) rather than this package.

This release of mpcplus adds support for:

* Installation as a separate standalone package on multiple platforms
* Create packaging for Arch Linux, CentOS, Fedora, Ubuntu, and Raspberry Pi OS
* Integrated features and customizations from MusicPlayerPlus
* Support for Arch-like systems (e.g. Manjaro Linux)

## Installation

Download the [latest Debian, Arch, or RPM package format release](https://github.com/doctorfree/mpcplus/releases) for your platform.

Install the package on Debian based systems by executing the command:

```bash
sudo apt install ./mpcplus_1.0.0-2.amd64.deb
```

or, on a Raspberry Pi:

```bash
sudo apt install ./mpcplus_1.0.0-2.armhf.deb
```

Install the package on Arch Linux based systems by executing the command:

```bash
sudo pacman -U ./mpcplus_1.0.0-2-x86_64.pkg.tar.zst
```

Install the package on RPM based systems by executing one of the following commands.

On Fedora Linux:

```bash
sudo yum localinstall ./mpcplus_1.0.0-2.fc36.x86_64.rpm
```

On CentOS Linux:

```bash
sudo yum localinstall ./mpcplus_1.0.0-2.el8.x86_64.rpm
```

### PKGBUILD Installation

To install on a Raspberry Pi running Arch Linux, mpcplus must be built from sources using the Arch PKGBUILD files provided in `mpcplus-pkgbuild-1.0.0-2.tar.gz`. This process can be performed on any `x86_64` or `armv7h ` architecture system running Arch Linux. An `x86_64` architecture precompiled package is supplied (see above). To rebuild this package from sources, extract `mpcplus-pkgbuild-1.0.0-2.tar.gz` and use the `makepkg` command to download the sources, build the binaries, and create the installation package:

```
tar xzf mpcplus-pkgbuild-1.0.0-2.tar.gz
cd mpcplus
makepkg --force --log --cleanbuild --noconfirm --syncdeps
```

## Configuration

**[TODO:]** Instructions on how to configure MPD fifo

If the `mpcinit` mpcplus initialization did not correctly detect the music library location then edit `/etc/mpd.conf` or `~/.config/mpd/mpd.conf`, set the `music_directory` correctly, and run `mpcinit sync`.

See the [mpcplus README](https://github.com/doctorfree/mpcplus#readme) for additional configuration info.

## Removal

Removal of the package on Debian based systems can be accomplished by issuing the command:

```bash
sudo apt remove mpcplus
```

Removal of the package on RPM based systems can be accomplished by issuing the command:

```bash
sudo yum remove mpcplus
```

Removal of the package on Arch Linux based systems can be accomplished by issuing the command:

```bash
sudo pacman -Rs mpcplus
```

## Building mpcplus from source

mpcplus can be compiled, packaged, and installed from the source code repository. This should be done as a normal user with `sudo` privileges:

```
# Retrieve the source code from the repository
git clone https://github.com/doctorfree/mpcplus.git
# Enter the mpcplus source directory
cd mpcplus
# Install the necessary build environment (not necessary on Arch Linux)
scripts/install-dev-env.sh
# Compile mpcplus and create an installation package
./mkpkg
# Install mpcplus and its dependencies
./Install
```

The `mkpkg` script detects the platform and creates an installable package in the package format native to that platform. After successfully building mpcplus, the resulting installable package will be found in the `./releases/<version>/` directory.

## Changelog

Changes in version 1.0.0 release 2 include:

* Support for Arch-like systems (e.g. Manjaro Linux)

Changes in version 1.0.0 release 1 include:

* Installation as a separate standalone package on multiple platforms
* Integrated features and customizations from MusicPlayerPlus
* Create packaging for Arch Linux, CentOS, Fedora, Ubuntu, and Raspberry Pi OS

See [CHANGELOG.md](https://github.com/doctorfree/mpcplus/blob/master/CHANGELOG.md) for a full list of changes in every mpcplus release
