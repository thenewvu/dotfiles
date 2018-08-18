" set window height to 5
exe "15 wincmd _"
" don't show up in the buffer list
setlocal nobuflisted
" <esc> to close
nnoremap <buffer><silent> <esc> :cclose<bar>lclose<CR>
