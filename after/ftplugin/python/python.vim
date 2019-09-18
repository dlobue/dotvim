" syntax folding
" set foldmethod=syntax
" let g:vimsyn_folding='afP'

"make periods word boundaries
set iskeyword-=.

set completeopt=menuone,longest,preview

" change SpellBad highlight color
"highlight SpellBad term=underline gui=undercurl guisp=#533B38
"highlight SpellBad term=underline gui=undercurl guisp=#000000
"hi SpellBad        ctermfg=darkred guifg=darkred
highlight SpellBad term=reverse ctermbg=1

" disable fucking error signs
let g:semshi#error_sign=v:false
" let g:semshi#update_delay_factor=0.0
" default value for semshiSelected
" hi semshiSelected        ctermfg=231 guifg=#ffffff ctermbg=161 guibg=#d7005f
" the default config of semshiSelected is too distracting. clear it and use
" something more subtle.
hi clear semshiSelected
hi semshiSelected cterm=bold,italic gui=bold,italic

if executable('cgrep')
    set grepprg=cgrep\ -r\ --language-filter=Python\ $*
endif

" use black-macchiato to format code
if executable('black-macchiato')
    set formatprg=black-macchiato
endif
