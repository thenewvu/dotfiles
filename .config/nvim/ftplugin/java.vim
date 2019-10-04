setlocal foldenable foldmethod=marker foldmarker={,} foldtext=FoldJava()
setlocal commentstring=//%s

function! FoldJava()
    let l:start = substitute(getline(v:foldstart), '^\s*', '', '')
    let l:end = getline(v:foldend)
    let l:indent = repeat(' ', indent(v:foldstart))

    let l:start = substitute(l:start, '{.*$', '{', '')
    let l:end = substitute(l:end, '^.*}', '}', '')

    return l:indent . l:start . '▾' . l:end
endfunction 


