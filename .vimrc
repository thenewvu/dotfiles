set noswapfile
set hlsearch
set laststatus=2
set tabstop=2 softtabstop=0 expandtab shiftwidth=2
set number
syntax on

" automatically set syntax *.md files to markdown
autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
