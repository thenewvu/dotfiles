set noswapfile
set hlsearch
set laststatus=2
set number
set autoindent
set expandtab
set copyindent
set preserveindent
set softtabstop=0
set shiftwidth=0
set tabstop=2
set listchars=trail:·,tab:»\ 
set list
highlight SpecialKey ctermfg=7 guifg=gray
syntax on

" automatically set syntax *.md files to markdown
autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
