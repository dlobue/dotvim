set nocompatible
exec 'source ' . expand('<sfile>:p:h') . '/.vim/bundle/pathogen/autoload/pathogen.vim'
call pathogen#infect()
" generate helptags
Helptags

if has('gui_running')
    colorscheme mustang
elseif &term =~ 'xterm-256color'
    set t_Co=256
    colorscheme lucius
else
    colorscheme wargrey
endif

let g:CSApprox_attr_map = { 'bold' : 'bold', 'italic' : '', 'sp' : '' }

filetype on
syntax on
filetype plugin indent on
filetype plugin on
" set iskeyword+=.

" disable annoying gvim stuff
set guioptions-=T
set guioptions-=L
set guioptions-=r
set guioptions-=a
set guioptions-=m
set clipboard=

set autoindent " Copy indent from current line when starting a new line.
set backspace=indent,eol,start
set ignorecase " case insensitive search
set smartcase " make search case-sensitive if search str has caps
set hlsearch " highlight results
set wildmenu " show some autocomplete options in status bar
set foldlevel=0 " default fold level. 0 for all closed
set hidden " allow unmodified buffers to be backgrounded
set number " show line and column number
set textwidth=0 " do not break lines when line lenght increases
set scrolloff=3
set sidescrolloff=3
"set showmode
"set showcmd
"set laststatus=2



inoremap <Leader>\ <Esc>
nnoremap <Leader>\ <Esc>
vnoremap <Leader>\ <Esc>
inoremap <Leader>i <Esc>`^
inoremap <Leader>a <Esc>
set timeoutlen=400

"vimdiff opts
set diffopt=filler
set diffopt+=iwhite
set diffopt+=icase
set diffopt+=horizontal




" By default, it goes without auto-wrap. If I want, I can type <C-B> to toggle
" auto-wrap. Another <C-B> toggles back.
" set sr fo=roqm1 tw=64
" im <C-B> <C-O>:setl sr! fo<C-R>=strpart("-+",&sr,1)<CR>=tc<CR>

" if virtualedit=insert, use the following binding instead
" im <C-B> <C-O>:setl sr! fo<C-R>=strpart("-+",&sr,1)<CR>=tc<CR>_<BS><Right>

 " enter spaces when tab is pressed:
"set expandtab
" user 4 spaces to represent a tab
"set softtabstop=4
" number of space to use for auto indent
" you can use >> or << keys to indent current line or selection
" in normal mode.
"set shiftwidth=4

" remove all trailing whitespace
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
" toggles turning on paste mode for safe pasting from the clipboard
" (prevents auto-indentation from going nuts)
nnoremap <F6> :set paste!<CR>
" toggle line numbers and fold column for easy copying:
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>

function! DeTab()
    set tabstop=4
    :retab
endfunction



" move between vim tabs with ALT+[Left|Right]Arrow
map <silent><A-Right> :tabnext<CR>
map <silent><A-Left> :tabprevious<CR>


function TabLeft()
   let tab_number = tabpagenr() - 1
   if tab_number == 0
      execute "tabm" tabpagenr('$') - 1
   else
      execute "tabm" tab_number - 1
   endif
endfunction

function TabRight()
   let tab_number = tabpagenr() - 1
   let last_tab_number = tabpagenr('$') - 1
   if tab_number == last_tab_number
      execute "tabm" 0
   else
      execute "tabm" tab_number + 1
   endif
endfunction




let g:localvimrc_sandbox=0
let g:notesRoot = '~/docs/notes'

let g:pcs_hotkey = 1
let g:pcs_check_when_saving = 1

let s:configured_vindect = 1

"let g:SuperTabDefaultCompletionType = "context"

"set statusline = "%{fugitive#statusline()}"

au BufRead,BufNewFile *.mako set filetype=mako
au BufRead,BufNewFile *.ghtml set filetype=genshi
au BufRead,BufNewFile *.ghr set filetype=ghrml

" ctrl+right to goto source of function under the cursor
map <silent><C-Left> <C-T>
" ctrl+left arrow to go back
map <silent><C-Right> <C-]>

nnoremap FF :NERDTreeToggle<CR>

" Taglist variables
" Display function name in status bar:
let g:ctags_statusline=1
" Automatically start script
let generate_tags=1
" Shorter commands to toggle Taglist display
"nnoremap TT :TlistToggle<CR>
"" map <F4> :TlistToggle<cr>
"" Various Taglist diplay config:
"let Tlist_Ctags_Cmd = 'ctags'
"let Tlist_Use_Right_Window = 1
"let Tlist_Compact_Format = 1
"let Tlist_Exit_OnlyWindow = 1
"let Tlist_GainFocus_On_ToggleOpen = 1
"let Tlist_File_Fold_Auto_Close = 1
"" Displays taglist results in a vertical window:
"let Tlist_Use_Horiz_Window=0


nnoremap TT :TagbarToggle<CR>

let g:tagbar_compact = 1
let g:tagbar_autofocus = 1
let g:tagbar_autoshowtag = 1
let g:tagbar_width = 30


if has('cscope')
    set cscopetag cscopeverbose
endif


function! _path_to_parts(path)
    let l:frags = split(a:path, '/')
    let l:tagpaths = []
    let l:i = 0
    while l:i < len(l:frags)
        let l:_tp = '/' . join(l:frags[:l:i], '/') . '/tags'
        if filereadable(l:_tp)
            let l:tagpaths += [l:_tp]
        endif
        let l:i += 1
    endwhile
    return reverse(l:tagpaths)
endfunction

function! BuildTagsFromPath()
    return join(pathogen#uniq(extend(_path_to_parts(expand('%:p:h')), _path_to_parts(getcwd()))), ',')
endfunction

exec 'set tags =' . BuildTagsFromPath()


" Remember last location in file
"if has("autocmd")
  "au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    "\| exe "normal g'\"" | endif
"endif


