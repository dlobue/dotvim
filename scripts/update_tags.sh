#!/usr/bin/bash

SRC_DIR=$@

if [ -z "$SRC_DIR" ]; then
    echo "ERROR: Missing argument: Source dir"
    exit 1
fi

# PROJECT_DIR=$(dirname "$0")
# cd $PROJECT_DIR

find ${SRC_DIR} -type f -name '*.py' > cscope.files

ctags -L cscope.files
pypy /root/projects/python-reference/pycscope/pycscope-0.3/pycscope.py -i cscope.files
#pycscope.py -i cscope.files

