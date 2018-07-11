setlocal wrap
setlocal textwidth=80
setlocal formatoptions-=l " auto wrap long lines (>textwidth)
setlocal linebreak
setlocal foldcolumn=1

let g:markdown_folding = 1

" underline markdown headers
" Ref: https://goo.gl/6zf93B
nnoremap <leader>mh yypVr-
nnoremap <leader>mhh yypVr=
