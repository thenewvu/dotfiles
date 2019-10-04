setlocal foldenable foldtext=FoldPy()

function! FoldPy()
    let l:start = substitute(getline(v:foldstart), '^\s*', '', '')
    let l:indent = repeat(' ', indent(v:foldstart))

    return l:indent . l:start . ' ⤸'
endfunction 
