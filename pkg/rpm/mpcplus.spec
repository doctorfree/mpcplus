Name: mpcplus
Version:    %{_version}
Release:    %{_release}%{?dist}
BuildArch:  x86_64
AutoReqProv: no
%if 0%{?centos} > 0
Requires: boost, fftw-libs, libcurl, libmpdclient, ncurses, readline, taglib
%else
Requires: boost, fftw-libs, libcurl, libmpdclient, ncurses, readline, taglib, mpc
%endif
URL:        https://github.com/doctorfree/mpcplus
Vendor:     Doctorwhen's Bodacious Laboratory
Packager:   ronaldrecord@gmail.com
License     : GPLv2+
Summary     : Featureful ncurses based MPD client with spectrum visualizer

%global __os_install_post %{nil}

%description
A featureful ncurses based MPD client inspired by ncmpcpp. The main features are:

- tag editor
- playlist editor
- easy to use search engine
- media library
- music visualizer
- ability to fetch artist info from last.fm
- new display mode
- alternative user interface
- ability to browse and add files from outside of MPD music directory

%prep

%build

%install
cp -a %{_sourcedir}/usr %{buildroot}/usr

%pre

%post

%preun

%files
/usr
%exclude %dir /usr/share/man/man1
%exclude %dir /usr/share/man
%exclude %dir /usr/share/doc
%exclude %dir /usr/share/menu
%exclude %dir /usr/share
%exclude %dir /usr/bin

%changelog
