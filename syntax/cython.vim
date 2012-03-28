" Vim syntax file
" Language:     Cython
" Maintainer:   Marco Barisione <marco.bari@people.it>
" URL:          http://marcobari.altervista.org/cython_vim.html
" Last Change:  2011 May 14

" 2011-05-14 - Don't clash with original pyrex and some whitespace fix
"               by Matteo Panella (morpheus@level28.org)
" 2008-04-08 - Updated to support Cython (http://www.cython.org/)
"               by Greg A. Jandl (greg.jandl@gmail.com)

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Read the Python syntax to start with
if version < 600
  so <sfile>:p:h/python.vim
else
  runtime! syntax/python.vim
  unlet b:current_syntax
endif

" cython extentions
syn keyword cythonStatement     cdef cpdef typedef ctypedef sizeof
syn keyword cythonType          int long short float double char object void
syn keyword cythonType          signed unsigned
syn keyword cythonType          size_t Py_ssize_t
syn keyword cythonType          bint
syn keyword cythonStructure     struct union enum
syn keyword cythonPrecondit     include cimport
syn keyword cythonAccess        public private property readonly extern api
syn keyword cythonGilAttrs      gil nogil
" If someome wants Python's built-ins highlighted probably he
" also wants cython's built-ins highlighted
if exists("python_highlight_builtins") || exists("cython_highlight_builtins")
    syn keyword cythonBuiltin   NULL
endif

" This deletes "from" from the keywords and re-adds it as a
" match with lower priority than cythonForFrom
" Check what version of python.vim we're dealing with
redir @a
silent! exec 'syntax list '
redir END
let syn_full = "\n".@a

if match(syn_full, '.*pythonPreCondit.*') > -1
    " Upstream (svn.python.org) python.vim
    syn clear   pythonPreCondit
    syn keyword pythonPreCondit import
    syn match   pythonPreCondit "from"
else
    " Bundled python.vim
    syn clear   pythonInclude
    syn keyword pythonInclude import
    syn match   pythonInclude "from"
endif

" With "for[^:]*\zsfrom" VIM does not match "for" anymore, so
" I used the slower "\@<=" form
syn match   cythonForFrom       "\(for[^:]*\)\@<=from"

" Default highlighting
if version >= 508 || !exists("did_cython_syntax_inits")
  if version < 508
    let did_cython_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  HiLink cythonStatement        Statement
  HiLink cythonType             Type
  HiLink cythonStructure        Structure
  HiLink cythonPrecondit        PreCondit
  HiLink cythonAccess           cythonStatement
  HiLink cythonGilAttrs         cythonStatement
  if exists("python_highlight_builtins") || exists("cython_highlight_builtins")
      HiLink cythonBuiltin      Function
  endif
  HiLink cythonForFrom          Statement

  delcommand HiLink
endif

let b:current_syntax = "cython"
