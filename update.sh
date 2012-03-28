#!/bin/sh
git submodule foreach --recursive git clean -f
git submodule update --init --recursive
git submodule foreach --recursive git checkout master
git submodule foreach --recursive git pull --rebase
git status

