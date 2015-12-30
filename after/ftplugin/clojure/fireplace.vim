
command! StartAndConnectClojureRepl call StartClojureRepl() | 
            \ call WaitUntilPortInuse(g:repl_port) |
            \ exec 'Connect nrepl://localhost:' . g:repl_port

function! WaitUntilPortInuse(port)
    let l:c = 0
    let l:max = 10 * 1000 / 500
    echo 'Waiting for nREPL to finish loading'
    while !(s:check_port_inuse(a:port) || l:c >= l:max)
        let l:c += 1
        sleep 500m
    endwhile
endfunction

function! StartClojureRepl()
    let g:repl_port = s:get_unused_port()
    if empty(g:repl_port)
        echoe 'Problem getting unused port number!'
        return
    endif
    "let l:procobj = vimproc#popen2('setsid lein repl :headless :port '. g:repl_port)
    let l:procobj = vimproc#popen2('setsid lein update-in :source-paths conj \"'. getcwd() .'\" -- update-in :test-paths conj \"'. getcwd() .'\" -- repl :headless :port '. g:repl_port)
    if empty(l:procobj)
        echoe 'Problem starting repl! procobj empty!'
        return
    endif
    call s:close_all(l:procobj)
    let g:repl_pid = procobj.pid
    augroup clojure_repl
      autocmd VimLeavePre * call KillClojureRepl(g:repl_pid)
    augroup END
endfunction

function! KillClojureRepl(pid)
    if CheckChildAlive(a:pid)
        py import os, vim
        py os.killpg(int(vim.eval('a:pid')), 15)
        "py ctypes.CDLL('libc.so.6').kill(-1 * int(vim.eval('a:pid')), 15)
        "call system('pkill -g '. a:pid)
    endif
endfunction

function! CheckChildAlive(pid)
    let l:repl_ppid = s:get_ppid(a:pid)
    if empty(l:repl_ppid)
        return 0
    endif
    return str2nr(l:repl_ppid) == getpid()
endfunction

function! s:get_ppid(pid)
    if !filereadable('/proc/'.a:pid.'/stat')
        " not alive
        return
    endif
    return split( readfile('/proc/'.a:pid.'/stat', 1)[0], '\W\+')[3]
endfunction

function! s:get_unused_port()
    while 1
        let l:port = Random(30000, 60000)
        let l:inuse_result = s:check_port_inuse(l:port)
        if l:inuse_result == -1
            echoe 'error while checking to see if port was in use'
            return
        elseif !l:inuse_result
            return l:port
        endif
    endwhile
endfunction

function! CheckPortInuse(port)
    return s:check_port_inuse(a:port)
endfunc

function! s:check_port_inuse(port)
    try
        for tcpver in ['tcp6', 'tcp']
            let l:data = map(readfile('/proc/net/'. tcpver, 0)[1:], 'str2nr(split(v:val, "\\W\\+")[2], 16)')
            if index(l:data, a:port) != -1
                return 1
            endif
        endfor
    catch
        echoe 'Unable to check to see if port was in use!'
        throw v:exception
    endtry
    return 0
endfunction

function! s:close_all(self) "{{{
  if has_key(a:self, 'stdin')
    call a:self.stdin.close()
  endif
  if has_key(a:self, 'stdout')
    call a:self.stdout.close()
  endif
  if has_key(a:self, 'stderr')
    call a:self.stderr.close()
  endif
endfunction"}}}

