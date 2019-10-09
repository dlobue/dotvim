
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

function! utils#match(...)
  let b = call("match",a:000)
  let e = call("matchend",a:000)
  let s = call("matchlist",a:000)
  if s == []
    let s = ["","","","","","","","","",""]
  endif
  return [b,e] + s
endfunction

function! utils#findatoffset(string,pattern,offset)
  let line = a:string
  let curpos = 0
  let offset = a:offset
  while strpart(line,offset,1) == " "
    let offset += 1
  endwhile
  let [start,end,string;caps] = utils#match(line,a:pattern,curpos,0)
  while start >= 0
    if offset >= start && offset < end
      break
    endif
    let curpos = start + 1
    let [start,end,string;caps] = utils#match(line,a:pattern,curpos,0)
  endwhile
  return [start,end,string] + caps
endfunction

function! utils#findinline(pattern)
  return utils#findatoffset(getline('.'),a:pattern,col('.')-1)
endfunction

function! utils#replaceinline(start,end,new)
  let line = getline('.')
  let before_text = strpart(line,0,a:start)
  let after_text = strpart(line,a:end)
  " If this generates a warning it will be attached to an ugly backtrace.
  " No warning at all is preferable to that.
  silent call setline('.',before_text.a:new.after_text)
  call setpos("'[",[0,line('.'),strlen(before_text)+1,0])
  call setpos("']",[0,line('.'),a:start+strlen(a:new),0])
endfunction

function! InlineDec2Hex()
    let [start,end,string;caps] = utils#findinline('\d\+')
    if string != ""
      call utils#replaceinline(start,end, printf('%02x', string))
    endif
endfunction
