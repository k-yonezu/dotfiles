#!/bin/sh
./configure \
	--enable-fail-if-missing \
	--prefix=${HOME}/local \
	--with-features=huge \
	--enable-multibyte=yes \
	--enable-luainterp=yes \
	--with-lua-prefix=${HOME}/local \
	--enable-pythoninterp \
	--with-python-config-dir=/usr/lib/python2.7/config
