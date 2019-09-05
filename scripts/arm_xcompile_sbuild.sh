#!/usr/bin/env bash

_user=matt
_dist=stretch
_mirror=ftp://ftp.us.debian.org/debian/

set -x

sudo sbuild-adduser $_user
sudo sbuild-createchroot $_dist /srv/chroots/$_dist-arm64-cross $_mirror
mv /etc/schroot/chroot.d/$_dist-amd64-sbuild-* /etc/schroot/chroot.d/$_dist-arm64-cross
