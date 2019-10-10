set nocompatible
let g:pathogen_disabled = [
            \'vim-classpath',
            \'typescript-vim',
            \'vim-SyntaxRange',
            \]
            " \'vim-javascript',
            " \'ale',

if has('nvim')
    call add(g:pathogen_disabled, 'csapprox')
endif

exec 'source ' . fnamemodify(resolve(expand('<sfile>:p')), ':h') . '/bundle/pathogen/autoload/pathogen.vim'
call pathogen#infect()
" generate helptags
Helptags

if !has('nvim')
    let g:rehash256=1

    if !has('gui') || v:version < 703
        "disable csapprox if we don't have gui
        "it gives an annoying error otherwise
        let g:CSApprox_loaded = 1
    endif
    if has('gui_running')
        colorscheme mustang
        set lines=28 columns=122
    elseif &term =~ 'xterm-256color'
        set t_Co=256
        colorscheme lucius-orig
    else
        colorscheme wargrey
    endif

    let g:CSApprox_attr_map = { 'bold' : 'bold', 'italic' : '', 'sp' : '' }
else
    set background=dark
    colorscheme lucius
    LuciusBlack
    " set lines=28 columns=122
endif

filetype on
syntax on
filetype plugin indent on
filetype plugin on

" disable annoying gvim stuff
set guioptions-=T
set guioptions-=L
set guioptions-=r
set guioptions-=a
set guioptions-=m
set clipboard=

" when opening a file in a new split, the new file goes in the opposite (aka new) split
set splitbelow
set splitright

set directory=. " put swapfile in same directory as file
set pastetoggle=<F12>       " Sane indentation on pastes
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
set completeopt=longest,menu,preview
"set completeopt=longest,menu,menuone,preview
set history=1000
"set showmode
"set showcmd
"set laststatus=2
set maxmempattern=10000
let s:wordsfile = '/usr/share/dict/words'
if filereadable(s:wordsfile)
    exec 'set dictionary+=' . s:wordsfile
endif


au BufEnter * if &ft == 'qf' | set scrolloff=1 | endif
au BufLeave * if &ft == 'qf' | set scrolloff=3 | endif

au BufRead,BufNewFile *.jsm set filetype=javascript

" map nerdcommenter keystrokes to commentary plugin
nmap <Leader>c<Space> gcc
xmap <Leader>c<Space> gc
omap <Leader>c<Space> gc

set timeoutlen=400

"vimdiff opts
set diffopt+=filler
set diffopt+=iwhite
set diffopt+=icase

"mappings to emulate gt & gT, only for buffers
nmap gb :bn<CR>
nmap gB :bp<CR>

"ctrlp shortcuts
nnoremap <Leader>b :CtrlP<CR>
nnoremap <Leader>bb :CtrlPBuffer<CR>


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
nnoremap <silent> <F5> :call RemoveTrailingWhitespace()<CR>
" toggle line numbers and fold column for easy copying:
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>


inoremap <Leader>id <C-R>=strftime("%F %T %z")<CR>
nnoremap <Leader>id "=strftime("%F %T %z")<CR>P

inoremap <Leader>ir <C-R>=Random(10,90)<CR>
nnoremap <Leader>ir "=Random(10,90)<CR>P

" URL encode/decode selection
vnoremap <leader>en :!python -c 'import sys,urllib.parse;print(urllib.quote(sys.stdin.read().strip()))'<cr>
vnoremap <leader>de :!python -c 'import sys,urllib.parse;print(urllib.unquote(sys.stdin.read().strip()))'<cr>


let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabLongestHighlight = 1
let g:SuperTabLongestEnhanced = 1


let g:python_auto_complete_variables = 1
let g:python_auto_complete_modules = 1

let g:CommandTMaxHeight = 12

let g:localvimrc_ask = 0
let g:localvimrc_sandbox = 0
let g:notesRoot = '~/docs/notes'

let g:pcs_hotkey = 1
let g:pcs_check_when_saving = 1

let s:configured_vindect = 1

let g:syntastic_enable_signs=0
let g:ale_set_signs = 0
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_enabled = 0

let g:ctrlp_custom_ignore = { 'dir':  '\v[\/]\.(git|hg|svn|idea)$|\v[\/]target$|node_modules', 'file': '\v\.(exe|so|dll|class|pyc)$' }
"let g:ctrlp_custom_ignore = { 'dir':  '\v[\/]\.(git|hg|svn)$|\v[\/]target$', 'file': '\v\.(exe|so|dll|html|class)$' }
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*


let g:NERDCustomDelimiters = {
    \ 'text': { 'left': '#'}
\ }

nnoremap FF :NERDTreeToggle<CR>

" Display function name in status bar:
let g:ctags_statusline=1
" Automatically start script
let generate_tags=0
let g:generate_tags=0


nnoremap TT :TagbarToggle<CR>
nnoremap FG :GundoToggle<CR>

let g:tagbar_compact = 1
let g:tagbar_autofocus = 1
let g:tagbar_autoshowtag = 1
let g:tagbar_width = 30

"original
"command! -nargs=1 Silent  | execute ':silent !'.<q-args>  | execute ':redraw!'
"my more streamlined version
command! -nargs=1 -bar -bang Silent execute ':silent<bang> '.<q-args>  | redraw!
command! -nargs=1 Grep execute 'Silent! grep! '.<q-args> | cw
command! -nargs=1 LGrep execute 'Silent! lgrep! '.<q-args> | lw

command! SHighlightCoverage execute 'Silent! HighlightCoverage'
command! SToggleCoverage execute 'Silent! ToggleCoverage'

"lets get Silent working before i start messing with autocommands
"autocmd QuickFixCmdPost *grep* cwindow

if has('cscope')
    set cscopetag cscopeverbose

    "nmap <Leader>ss :cs find s <C-R>=<cword><CR>
    "nmap <Leader>sg :cs find g <C-R>=<cword><CR>
    "nmap <Leader>sc :cs find c <C-R>=<cword><CR>
    "nmap <Leader>st :cs find t <C-R>=<cword><CR>
    "nmap <Leader>se :cs find e <C-R>=<cword><CR>
    "nmap <Leader>sf :cs find f <C-R>=<cfile><CR>
    "nmap <Leader>si :cs find i ^<C-R>=<cfile>$<CR>
    "nmap <Leader>sd :cs find d <C-R>=<cword><CR>

    "nmap <Leader>ss :cs find s <C-R>=expand("<cword>")<CR><CR>
    "nmap <Leader>sg :cs find g <C-R>=expand("<cword>")<CR><CR>
    "nmap <Leader>sc :cs find c <C-R>=expand("<cword>")<CR><CR>
    "nmap <Leader>st :cs find t <C-R>=expand("<cword>")<CR><CR>
    "nmap <Leader>se :cs find e <C-R>=expand("<cword>")<CR><CR>
    "nmap <Leader>sf :cs find f <C-R>=expand("<cfile>")<CR><CR>
    "nmap <Leader>si :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    "nmap <Leader>sd :cs find d <C-R>=expand("<cword>")<CR><CR>

    nmap <Leader>ss :execute 'cs find s '. expand('<cword>')<CR>
    nmap <Leader>sg :execute 'cs find g '. expand('<cword>')<CR>
    nmap <Leader>sc :execute 'cs find c '. expand('<cword>')<CR>
    nmap <Leader>st :execute 'cs find t '. expand('<cword>')<CR>
    nmap <Leader>se :execute 'cs find e '. expand('<cword>')<CR>
    nmap <Leader>sf :execute 'cs find f '. expand('<cfile>')<CR>
    nmap <Leader>si :execute 'cs find i ^'. expand('<cfile>') .'$'<CR>
    nmap <Leader>sd :execute 'cs find d '. expand('<cword>')<CR>
endif

command! Scratch new +setlocal\ buftype=nofile\ bufhidden=hide\ noswapfile

au Syntax go,golang set tags+=/root/projects/go-reference/go/go1.1
au Syntax json setlocal foldmethod=syntax


autocmd SwapExists * :let b:swapname = v:swapname

let g:NERDTreeIgnore=['\~$', '\.pyc$']

let g:jedi#popup_on_dot = 0
" previously had show_call_signatures at 0
" changing to 2 to show call signatures in command line
let g:jedi#show_call_signatures = 2 " don't use jedi's syntax files. use our custom modified one which does this already
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#smart_auto_mappings = 1

" clojure

let g:clojure_fold=1
let g:xml_syntax_folding = 1

let g:jsx_ext_required = 0
let g:javascript_plugin_flow = 1

let g:terraform_align=1
let g:terraform_fold_sections=1

let g:EditorConfig_exclude_patterns = ['fugitive://.\*']

let g:vimsyn_folding = 'falmpPrt'

" let g:suda_smart_edit = 1

let python_no_doctest_code_highlight = 1
let python_no_doctest_highlight = 1
let python_space_error_highlight = 1

