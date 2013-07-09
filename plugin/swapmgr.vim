


function! Swapmgr_init()
    echom 'swapmgr init'
    augroup swapmgr_init
        autocmd!
        "TODO: do not run enable on quickfix, help, etc
        autocmd BufRead * :call Swapmgr_enable()
    augroup end
    if !exists('#swapmgr')
        call Swapmgr_enable()
    endif
endfunction

function! Swapmgr_disable()
    echom 'swapmgr disabled '. expand('%')
    augroup swapmgr
        autocmd! * <buffer>
    augroup end
    "augroup! swapmgr
endfunction

function! Swapmgr_enable()
    if exists('b:swapmgr_enabled')
        if exists('g:swapmgr_debug') && g:swapmgr_debug
            echom 'not enabling. swapmgr already enabled for buffer '. expand('%')
        endif
        return
    else
        let b:swapmgr_enabled = 1
    endif
    "TODO: do not run enable on quickfix, help, etc
    "TODO: check for RO, whether swap is already disabled, and for obviate
    "setting. if found do not enable
    if exists('g:swapmgr_debug') && g:swapmgr_debug
        echom 'swapmgr enabling: creating swapmgr augroup '. expand('%')
    endif
    augroup swapmgr
        autocmd! * <buffer>
        autocmd BufWinEnter <buffer> :call Swapmgr_on_bufenter()
        autocmd BufWinLeave,TabLeave <buffer> :call Swapmgr_on_bufexit()
    augroup end
endfunction

function! Swapmgr_on_bufenter()
    if exists('g:swapmgr_debug') && g:swapmgr_debug
        echom 'swapmgr on_bufenter '. expand('%')
    endif
    "TODO: check for RO, whether swap is already disabled, and for obviate
    "setting. if found do not enable
    set swf
    if undotree()['seq_last'] " if the buffer has been modified
        if exists('g:swapmgr_debug') && g:swapmgr_debug
            echom 'swapmgr on_bufenter: found history '. expand('%')
        endif
        call Swapmgr_disable()
    endif
endfunction

function! Swapmgr_on_bufexit()
    echom 'swapmgr on_bufexit'
    if undotree()['seq_last'] " if the buffer has been modified
        if exists('g:swapmgr_debug') && g:swapmgr_debug
            echom 'swapmgr on_bufexit: found history '. expand('%')
        endif
        call Swapmgr_disable()
    else
        if exists('g:swapmgr_debug') && g:swapmgr_debug
            echom 'swapmgr on_bufexit: --NO-- history '. expand('%')
        endif
        set noswf
    endif
endfunction

