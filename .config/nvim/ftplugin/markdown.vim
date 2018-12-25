setlocal wrap
setlocal textwidth=80
setlocal formatoptions-=l " auto wrap long lines (>textwidth)
setlocal linebreak
setlocal nolist
setlocal nonumber
setlocal conceallevel=2 concealcursor=vc

" underline markdown headers
" Ref: https://goo.gl/6zf93B
nnoremap <leader>mh yypVr-
nnoremap <leader>mhh yypVr=
