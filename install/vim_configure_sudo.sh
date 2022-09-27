#!/bin/sh
./configure \
	--enable-fail-if-missing \
	--enable-multibyte \
	--with-features=huge \
	--disable-selinux \
	--prefix=/usr/local \
	--enable-luainterp=yes \
	--enable-pythoninterp=dynamic \
	--enable-gui=gtk2 \
	--enable-xim \
	--enable-fontset \
