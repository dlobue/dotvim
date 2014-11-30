
function! Random(min, max)
    if !exists("g:seeded")
        call libcallnr("libc.so.6", "srand", localtime() )
        let g:seeded = 1
    endif
    return libcallnr("libc.so.6", "rand", 0 ) % (a:max - a:min + 1) + a:min
endfun 

