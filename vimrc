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

nnoremap <F3> :set tabstop=2<CR>:set tabstop=2<CR>:set softtabstop=2<CR>
nnoremap <F4> :set tabstop=4<CR>:set tabstop=4<CR>:set softtabstop=4<CR>

" Copy indent from current line when starting a new line.
set autoindent
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


" show line and column number
set number

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
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchWindows = 1

syntax on

au BufRead,BufNewFile *.mako set filetype=mako
au BufRead,BufNewFile *.ghtml set filetype=genshi
au BufRead,BufNewFile *.ghr set filetype=ghrml
