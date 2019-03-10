setlocal foldmethod=marker
setlocal foldmarker={,}

if executable('python')
  nnoremap <leader><space> :%!python -m json.tool<cr> 
endif
setlocal nofoldenable
