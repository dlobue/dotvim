" pydiction dictionary location
" let g:pydiction_location = "~/.vim/pydiction/complete-dict"

" syntax folding
set foldmethod=syntax
let g:vimsyn_folding='afP'

"text width before wrapping.
"set to 0 to use the terminal width
set textwidth=80

"make periods word boundaries
" set iskeyword-=.

"set a wrap margin of 2 characters at the end of each line, and do automatic
"word-wrapping as you type in text. 
"set wm=2

"let g:ifold_mode=2 

" python tags
set tags+=~/.vim/tags/python.ctags
set tags+=~/.vim/tags/python-sitelibs.ctags

" PySmell omnicompletion
setlocal omnifunc=pysmell#Complete

