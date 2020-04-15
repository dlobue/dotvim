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
    return join(utils#uniq(extend(_path_to_parts(expand('%:p:h')), _path_to_parts(getcwd()))), ',')
endfunction

exec 'set tags+=' . BuildTagsFromPath()
