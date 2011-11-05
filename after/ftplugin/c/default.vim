set textwidth=78
set autoindent smartindent              " turn on auto/smart indenting
set smarttab                            " make <tab> and <backspace> smarter

set formatoptions=tcqlron
set cinoptions=:0,l1,t0,g0

set foldmethod=syntax
let $kernel_version=system('uname -r | tr -d "\n"')
set tags+=/lib/modules/$kernel_version/build/tags,/usr/include/tags

