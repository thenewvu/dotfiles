setlocal foldmethod=marker foldmarker={,} foldtext=FoldRust()
setlocal commentstring=//%s
setlocal expandtab smarttab tabstop=4 shiftwidth=4 softtabstop=4

function! FoldRust()
    let l:start = substitute(getline(v:foldstart), '^\s*', '', '')
    let l:end = getline(v:foldend)
    let l:indent = repeat(' ', indent(v:foldstart))

    let l:start = substitute(l:start, '{.*$', '{', '')
    let l:end = substitute(l:end, '^.*}', '}', '')

    if l:end =~ "}.*\\"
        let l:end = "}"
    endif

    return l:indent . l:start . '▾' . l:end
endfunction 
