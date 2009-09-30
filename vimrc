set nocompatible
filetype on
syntax on
filetype plugin indent on
set iskeyword+=.
filetype plugin on
" colorscheme wargrey
colorscheme lucius
set paste

" show line and column number
set number

" enter spaces when tab is pressed:
set expandtab
" do not break lines when line lenght increases
set textwidth=0
" user 4 spaces to represent a tab
set tabstop=4
set softtabstop=4
" number of space to use for auto indent
" you can use >> or << keys to indent current line or selection
" in normal mode.
set shiftwidth=4

nnoremap <F3> :call ToggleTab()<CR>

" nnoremap <F3> :set tabstop=2<CR>:set tabstop=2<CR>:set softtabstop=2<CR>
" nnoremap <F4> :set tabstop=4<CR>:set tabstop=4<CR>:set softtabstop=4<CR>

function! ToggleTab()
    if &expandtab
        set tabstop=2
        set softtabstop=2
        set shiftwidth=2
    else
        set tabstop=4
        set softtabstop=4
        set shiftwidth=4
    endif
endfunction
        

" Copy indent from current line when starting a new line.
set autoindent
nnoremap <F6> :set noautoindent!<CR>
" makes backspace key more powerful.
set backspace=indent,eol,start
" shows the match while typing
" set incsearch
" case insensitive search
" set ignorecase
" show some autocomplete options in status bar
set wildmenu

" move between vim tabs with ALT+[Left|Right]Arrow
map <silent><A-Right> :tabnext<CR>
map <silent><A-Left> :tabprevious<CR>


" toggle line numbers and fold column for easy copying:
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>

" automatically save and restore folds
" au BufWinLeave * mkview
" au BufWinEnter * silent loadview

" this lets us put the marker in the file so that
" it can be shared across and stored in version control.
set foldmethod=marker
" this is for python, put
" # name for the folded text # {{{
" to begin marker and
" # }}}
" close to end it.
set commentstring=\ #\ %s
" default fold level, all open, set it 200 or something
" to make it all closed.
set foldlevel=0

" share clipboard with windows clipboard
" set clipboard+=unnamed

" set viminfo='100,f1
" minibufexplorer settings:j
" let g:miniBufExplMapWindowNavArrows = 1
" let g:miniBufExplMapCTabSwitchWindows = 1

let g:pcs_hotkey = 1
let g:pcs_check_when_saving = 1

let s:configured_vindect = 1

" turn on pysmell autocompletion in python files
" autocmd FileType python setlocal omnifunc=pysmell#Complete
autocmd FileType python set complete+=k~/.vim/syntax/python.vim isk+=.,(

au BufRead,BufNewFile *.mako set filetype=mako
au BufRead,BufNewFile *.ghtml set filetype=genshi
au BufRead,BufNewFile *.ghr set filetype=ghrml

" Tag files
"set tags+=/root/.vim/tags/python.ctags
"set tags+=/root/.vim/tags/python-sitelibs.ctags
" ctrl+right to goto source of function under the cursor
map <silent><C-Left> <C-T>
" ctrl+left arrow to go back
map <silent><C-Right> <C-]>

" Taglist variables
" Display function name in status bar:
let g:ctags_statusline=1
" Automatically start script
let generate_tags=1
" Displays taglist results in a vertical window:
let Tlist_Use_Horiz_Window=0
" Shorter commands to toggle Taglist display
nnoremap TT :TlistToggle<CR>
" map <F4> :TlistToggle<cr>
" Various Taglist diplay config:
let Tlist_Ctags_Cmd = 'ctags'
let Tlist_Use_Right_Window = 1
let Tlist_Compact_Format = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_File_Fold_Auto_Close = 1
