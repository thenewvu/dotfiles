setlocal foldenable foldtext=FoldPy()
setlocal expandtab smarttab tabstop=4 shiftwidth=4 softtabstop=4

function! FoldPy()
    let l:start = substitute(getline(v:foldstart), '^\s*', '', '')
    let l:indent = repeat(' ', indent(v:foldstart))

    return l:indent . l:start . ' ⤸'
endfunction 
