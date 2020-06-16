#!/usr/bin/bash

PROJECT_DIR=$(dirname "$0")
cd $PROJECT_DIR

find ${SRC_DIR} -type f -name '*.py' > cscope.files

ctags -L cscope.files
cscope -b -i cscope.files
