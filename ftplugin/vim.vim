" Folding via syntax is used for this filetype.
setlocal foldmethod=syntax
" can't set vimsyn here. it is too late.
" let g:vimsyn_folding = 'falmpPrt'

" Add : to keyword list so things like lookup by tags works
set iskeyword+=:

" Vim's command window ('q:') and the :options window also set filetype=vim. We
" do not want folding in these enabled by default, though, because some
" malformed :if, :function, ... commands would fold away everything from the
" malformed command until the last command.
if bufname('') =~# '^\%(' . (v:version < 702 ? 'command-line' : '\[Command Line\]') . '\|option-window\)$'
  " With this, folding can still be enabled easily via any zm, zc, zi, ...
  " command.
  setlocal nofoldenable
" else
"   " Fold settings for ordinary windows.
"   setlocal foldcolumn=4
endif
