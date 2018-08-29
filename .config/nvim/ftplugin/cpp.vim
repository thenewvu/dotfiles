setlocal foldmethod=marker
setlocal foldmarker={,}

if executable('clang-format')
  function! ClangFormatRange() range
    let l:lines = a:firstline . ':' . a:lastline
    pyf ~/.config/nvim/ftplugin/clang-format.py
  endfunction

  function! ClangFormat()
    if &mod
      let l:formatdiff = 1
    else
      let l:lines = 'all'
    endif
    pyf ~/.config/nvim/ftplugin/clang-format.py
  endfunction

  nnoremap <leader><space> :call ClangFormat()<cr> 
  vnoremap <leader><space> :call ClangFormatRange()<cr>
endif
