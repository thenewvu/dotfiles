setlocal foldmethod=marker
setlocal foldmarker={,}
setlocal commentstring=//%s
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4

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

augroup Cpp
  au BufRead,BufNewFile *.h set filetype=c
augroup END
