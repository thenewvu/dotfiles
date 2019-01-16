" set window height to 5
exe "10 wincmd _"
" don't show up in the buffer list
setlocal nobuflisted
setlocal signcolumn=no
" <esc> to close
nnoremap <buffer><silent> <esc> :cclose<bar>lclose<CR>
