setlocal wrap
setlocal textwidth=80
setlocal formatoptions-=l " auto wrap long lines (>textwidth)
setlocal linebreak
setlocal nolist
setlocal nonumber

let g:markdown_fenced_languages = ['c','cpp','go','javascript','python','java','objc','objcpp', 'make','vim','cmake','bash=sh']

" underline markdown headers
" Ref: https://goo.gl/6zf93B
nnoremap <leader>mh yypVr-
nnoremap <leader>mhh yypVr=
