" pydiction dictionary location
" let g:pydiction_location = "~/.vim/pydiction/complete-dict"

" syntax folding
set foldmethod=syntax
let g:vimsyn_folding='afP'

"text width before wrapping.
"set to 0 to use the terminal width
"set textwidth=80

"make periods word boundaries
" set iskeyword-=.

"set a wrap margin of 2 characters at the end of each line, and do automatic
"word-wrapping as you type in text. 
"set wm=2

set iskeyword-=.

"let g:ifold_mode=2 

" python tags
"set tags+=~/.vim/tags/python.ctags
"set tags+=~/.vim/tags/python-sitelibs.ctags

if executable('pydoc2')
    let g:pydoc_cmd = 'pydoc2'
endif


" PySmell omnicompletion
"setlocal omnifunc=pysmell#Complete
"set omnifunc=pythoncomplete#Complete

set completeopt=menuone,longest,preview

" Rope AutoComplete
let ropevim_vim_completion = 1
let ropevim_extended_complete = 1

" change SpellBad highlight color
"highlight SpellBad term=underline gui=undercurl guisp=#533B38
"highlight SpellBad term=underline gui=undercurl guisp=#000000
"hi SpellBad        ctermfg=darkred guifg=darkred
highlight SpellBad term=reverse ctermbg=1
