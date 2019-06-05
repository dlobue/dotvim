
function! _child_of_git()
    let l:pid = getpid()
    while l:pid > 1
        let [l:name, @_, l:pid] = split( readfile('/proc/'.l:pid.'/stat', 1)[0], '\W\+')[1:3]
        if l:name =~ 'git'
            return 1
        endif
    endwhile
    return 0
endfunction

if &diff
    if _child_of_git()
        " vimdiff was started by mergetool. make all the reference buffers
        " immutable to prevent confusion, since they cannot be written to
        " anyway.
        autocmd VimEnter * execute 'windo set noma nowrite filetype=git foldmarker=<<<<<<<,>>>>>>>' | set ma write
    endif
endif
