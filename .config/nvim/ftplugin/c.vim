if executable('clang-format')
  function! ClangFormatRange() range
    let l:lines = a:firstline . ':' . a:lastline
    pyf ~/.config/nvim/ftplugin/clang-format.py
  endfunction

  function! ClangFormat()
    if &mod
      let l:formatdiff = 1
    endif
    pyf ~/.config/nvim/ftplugin/clang-format.py
  endfunction

  nnoremap <leader>k :call ClangFormat()<cr> 
  vnoremap <leader>k :call ClangFormatRange()<cr>
endif
