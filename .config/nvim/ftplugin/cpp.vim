setlocal foldmethod=marker
setlocal foldmarker={,}
setlocal commentstring=//%s
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4


augroup Cpp
  au BufRead,BufNewFile *.h set filetype=c
augroup END
