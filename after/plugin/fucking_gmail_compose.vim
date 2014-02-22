
function! Gmail_from_compose()
    let l:winview = winsaveview()
    let _s=@/
    :%s/<br>/\r/g
    let @/=_s
    :nohl
    call winrestview(l:winview)
endfunction

function! Gmail_to_compose()
    let l:winview = winsaveview()
    let _s=@/
    :%s/\n/<br>/g
    let @/=_s
    :nohl
    call winrestview(l:winview)
endfunction

