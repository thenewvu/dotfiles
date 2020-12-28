setlocal wrap
setlocal textwidth=80
setlocal formatoptions-=l " auto wrap long lines (>textwidth)
setlocal linebreak
setlocal nolist
setlocal nonumber
setlocal conceallevel=2 concealcursor=
setlocal nofoldenable
setlocal spell

" underline markdown headers
" Ref: https://goo.gl/6zf93B
nnoremap <buffer> <leader>mh yypVr-
nnoremap <buffer> <leader>mhh yypVr=

nnoremap <buffer> <space> <nop>
