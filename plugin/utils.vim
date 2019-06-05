
function! Random(min, max)
    if !exists("g:seeded")
        call libcallnr("libc.so.6", "srand", localtime() )
        let g:seeded = 1
    endif
    return libcallnr("libc.so.6", "rand", 0 ) % (a:max - a:min + 1) + a:min
endfun 

function! DeTab()
    set tabstop=4
    :retab
endfunction

function! RemoveTrailingWhitespace()
    let l:winview = winsaveview()
    let _s=@/
    :%s/\s\+$//e
    let @/=_s
    :nohl
    call winrestview(l:winview)
endfunction

function! TabLeft()
   let tab_number = tabpagenr() - 1
   if tab_number == 0
      execute "tabm" tabpagenr('$') - 1
   else
      execute "tabm" tab_number - 1
   endif
endfunction

function! TabRight()
   let tab_number = tabpagenr() - 1
   let last_tab_number = tabpagenr('$') - 1
   if tab_number == last_tab_number
      execute "tabm" 0
   else
      execute "tabm" tab_number + 1
   endif
endfunction

function! s:DiffWithSaved()
  let l:filetype=&ft
  diffthis
  vnew
  exe "setlocal bt=nofile bh=wipe nobl noswf ft=" . l:filetype
  r ++edit # 
  0d_
  diffthis
endfunction

command! DiffOrig call s:DiffWithSaved()

function! CurrentFile()
    return resolve(expand('%:p'))
endfunction

function! YankCurrentFile()
    let @* = CurrentFile()
endfunction

nmap <Leader>yf :call YankCurrentFile()<CR>
