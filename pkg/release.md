[Mpcplus](https://github.com/doctorfree/mpcplus#readme) is an open source NCurses character-based Music Player Daemon (MPD) client inspired by `ncmpcpp`. The `mpcplus` MPD client is customized for integration with the [MusicPlayerPlus project](https://github.com/doctorfree/MusicPlayerPlus#readme) and the [Mppcava spectrum visualizer](https://github.com/doctorfree/mppcava#readme).

This major new release of mpcplus adds support for many new features including:

* Integration of the [Beets media library management system](https://beets.io/)

## Installation

Download the [latest Debian, Arch, or RPM package format release](https://github.com/doctorfree/mpcplus/releases) for your platform.

Install the package on Debian based systems by executing the command:

```bash
sudo apt install ./mpcplus_1.0.0-1.amd64.deb
```

or, on a Raspberry Pi:

```bash
sudo apt install ./mpcplus_1.0.0-1.armhf.deb
```

Install the package on Arch Linux based systems by executing the command:

```bash
sudo pacman -U ./mpcplus_1.0.0-1-x86_64.pkg.tar.zst
```

Install the package on RPM based systems by executing one of the following commands.

On Fedora Linux:

```bash
sudo yum localinstall ./mpcplus_1.0.0-1.fc36.x86_64.rpm
```

On CentOS Linux:

```bash
sudo yum localinstall ./mpcplus_1.0.0-1.el8.x86_64.rpm
```

### PKGBUILD Installation

To install on a Raspberry Pi running Arch Linux, mpcplus must be built from sources using the Arch PKGBUILD files provided in `mpcplus-pkgbuild-1.0.0-1.tar.gz`. This process can be performed on any `x86_64` or `armv7h ` architecture system running Arch Linux. An `x86_64` architecture precompiled package is supplied (see above). To rebuild this package from sources, extract `mpcplus-pkgbuild-1.0.0-1.tar.gz` and use the `makepkg` command to download the sources, build the binaries, and create the installation package:

```
tar xzf mpcplus-pkgbuild-1.0.0-1.tar.gz
cd mpcplus
makepkg --force --log --cleanbuild --noconfirm --syncdeps
```

## Configuration

**[TODO:]** Instructions on how to configure MPD fifo and music_directory etc

If the music library is located somewhere other than `$HOME/Music` or `$HOME/music` then rather than `mppinit`, execute the command `mppinit -l /path/to/library`.

If the `mppinit` mpcplus initialization did not correctly detect the music library location then edit `~/.config/mpprc`, set the `MUSIC_DIR` correctly, and run `mppinit sync`.

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

Changes in version 1.0.0 release 1 include:

* Arch Linux build and packaging support
* CentOS Linux build and packaging support

See [CHANGELOG.md](https://github.com/doctorfree/mpcplus/blob/master/CHANGELOG.md) for a full list of changes in every mpcplus release
