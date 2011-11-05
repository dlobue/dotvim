#!/bin/bash

cd /usr/include
find . -name '*.h' > cscope.files
cscope -b
rm -f tags
#cat cscope.files | xargs -n100 ctags -a 
ctags -L cscope.files

cd /lib/modules/$(uname -r)/build/
make -j2 tags cscope
