#!/bin/bash

FIXESDIR=$(dirname `readlink -f "$0"`)
RAINBOWDIR="${FIXESDIR}/../bundle/rainbow_parentheses"

pushd $RAINBOWDIR
git apply "${FIXESDIR}/rainbow-fold-fix.patch"

