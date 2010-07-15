" pydiction dictionary location
" let g:pydiction_location = "~/.vim/pydiction/complete-dict"

" syntax folding
set foldmethod=syntax
let g:vimsyn_folding='afP'

"let g:ifold_mode=2 

" python tags
set tags+=~/.vim/tags/python.ctags
set tags+=~/.vim/tags/python-sitelibs.ctags

" PySmell omnicompletion
setlocal omnifunc=pysmell#Complete


" change SpellBad highlight color
highlight SpellBad guisp=#533B38
