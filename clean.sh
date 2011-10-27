#!/bin/sh
git submodule foreach --recursive git checkout master
git submodule foreach --recursive git clean -f
git status

