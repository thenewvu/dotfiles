syntax enable                                                         " enable syntax processing

set tabstop=2                                                         " number of visual spaces per TAB
set softtabstop=2                                                     " number of spaces in tab when editing
set expandtab                                                         " tabs are spaces

set number                                                            " show line numbers
set showcmd                                                           " show command in bottom bar
set laststatus=2

set wildmenu                                                          " visual autocomplete for command menu
set lazyredraw                                                        " redraw only when we need to.
set showmatch                                                         " highlight matching [{()}]

set incsearch                                                         " search as characters are entered
set hlsearch                                                          " highlight matches
                                                                      " \space to turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

set textwidth=0
set wrapmargin=0

set foldenable                                                        " enable folding
set foldlevelstart=10                                                 " open most folds by default
                                                                      " space to open/closes folds
nnoremap <space> za
set foldmethod=indent                                                 " fold based on indent level

                                                                      " visualize whitespaces
set listchars=trail:·,tab:»\ 
set list
highlight SpecialKey ctermfg=7 guifg=gray

                                                                      " move vertically by visual line
nnoremap j gj
nnoremap k gk

                                                                      " move to beginning/end of line
nnoremap B ^
nnoremap E $

                                                                      " $/^ doesn't do anything
nnoremap $ <nop>
nnoremap ^ <nop>

                                                                      " start vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'terryma/vim-multiple-cursors'
Plugin 'scrooloose/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim'
                                                                      " finish vundle
call vundle#end()
filetype plugin indent on

                                                                      " fix *.md files are not recognized as markdown files
autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

map <C-b> :NERDTreeToggle<CR>
