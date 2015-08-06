#!/bin/sh
git submodule update --init
git submodule foreach "git pull -r origin master"
test -L mdref/refs || ln -s ../refs mdref/refs
