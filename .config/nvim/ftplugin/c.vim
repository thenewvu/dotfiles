setlocal foldenable foldmethod=marker foldmarker={,} foldtext=FoldC()
setlocal commentstring=//%s
setlocal expandtab smarttab tabstop=4 shiftwidth=4 softtabstop=4

function! FoldC()
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

let g:c_no_if0 = 0
let g:c_no_utf = 0
let g:c_no_bsd = 0
