setlocal foldenable foldmethod=marker foldmarker={,} foldtext=FoldC() foldnestmax=1
setlocal commentstring=//%s
setlocal nowrap breakat=, breakindentopt=shift:0

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
