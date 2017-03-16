""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UTILS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" function that toggles vietnamese telex keymap
let g:keymap_vi = 0
function! ToggleKeymapVietnamese()
    if g:keymap_vi
        let g:keymap_vi = 0
        execute "set keymap="
    else
        execute "set keymap=vietnamese-telex"
        let g:keymap_vi = 1
    endif
endfunction

" LightLine util functions
function! LightLineModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

function! LightLineReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return "READONLY"
  else
    return ""
  endif
endfunction

function! LightLineFugitive()
  return exists('*fugitive#head') ? fugitive#head() : ''
endfunction

function! LightLineKeyMap()
  return &keymap
endfunction

function! LightLineTabFilename(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  let bufnum = buflist[winnr - 1]
  let bufname = expand('#'.bufnum.':F')
  return strlen(bufname) ? substitute(bufname, '.*/\([^/]\+/\)', '\1', '') : '[No name]'
endfunction

" function that returns a cleaner fold text title
" ref: http://www.gregsexton.org/2011/03/improving-the-text-displayed-in-a-fold/
function! GenFoldText()
  "get first non-blank line
  let foldstart = v:foldstart
  while getline(foldstart) =~ '^\s*$' | let foldstart = nextnonblank(foldstart + 1)
  endwhile
  if foldstart > v:foldend
    let line = getline(v:foldstart)
  else
    let line = substitute(getline(foldstart), '\t', repeat(' ', &tabstop), 'g')
  endif

  let w = winwidth(0) - &foldcolumn - ((&number || &relativenumber) ? 8 : 0)
  let foldSize = 1 + v:foldend - v:foldstart
  let foldSizeStr = " " . foldSize . " lines "
  let lineCount = line("$")
  let foldPercentage = printf("[%4.1f", (foldSize*1.0)/lineCount*100) . "%] "
  let expansionString = repeat(".", w - strwidth(foldSizeStr.line.foldPercentage))
  return line . expansionString . foldSizeStr . foldPercentage
endf

" function to sort lines by length in descending order
function! SortLinesByLengthDesc() range
    execute a:firstline . "," . a:lastline . 's/^\(.*\)$/\=strdisplaywidth( submatch(0) ) . " " . submatch(0)/'
    execute a:firstline . "," . a:lastline . 'sort! n'
    execute a:firstline . "," . a:lastline . 's/^\d\+\s//'
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BEHAVIOR SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" disable backup and swap file
set nobackup
set noswapfile

" leader as ;
let mapleader = ";"

" auto source .vimrc on change
augroup auto_source_vimrc
  autocmd!
  autocmd BufWritePost .vimrc source %
  autocmd BufWritePost .vimrc :call lightline#update()
augroup END

" auto source .Xresources on change
augroup auto_source_xresources
  autocmd!
  autocmd BufWritePost .Xresources silent !xrdb ~/.Xresources
augroup END

" auto open *.md as markdown
augroup open_md_as_markdown
  autocmd!
  autocmd BufNewFile,BufFilePre,BufRead *.md,README,readme set filetype=markdown
augroup END

augroup trim_trailing_whitespaces
  autocmd BufWritePre *.js %s/\s\+$//e
augroup END

" enable syntax processing
syntax enable

" display a confirm dialog when closing an unsaved file
set confirm

" set default encoding
set encoding=utf-8

" use the system clipboard
set clipboard^=unnamedplus,unnamed

" open files in new tabs from quick list
set switchbuf+=usetab,newtab

" enable auto-indenting when pasting by default
" set paste

" autoreload when files are changed outside of vim
set autoread

" make backspace work like most other apps
set backspace=indent,eol,start

" fix delete key doesn't work as expected
:fixdel

" set maximum of tabs
set tabpagemax=5

" enable mouse interactive
set mouse=a

" search ignore case by default
set ignorecase

" search with smart case
set smartcase

" optimize rendering
set lazyredraw
set ttyfast

" search as characters are entered
set incsearch

" enable folding
set foldenable
" set fold method to `syntax`
set foldmethod=syntax
" only fold the first level
set foldnestmax=100 foldlevel=0
" auto fold for javascript
let javaScript_fold=1

" syntastic settings
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_loc_list_height = 2
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1
let g:syntastic_full_redraws=1
let g:syntastic_javascript_checkers = ['standard']
let g:syntastic_javascriptjsx_checkers = ['standard']

" format js files on save in suckless way
" ref: http://learnvimscriptthehardway.stevelosh.com/chapters/14.html
:augroup auto_format_js
: autocmd!
: autocmd BufWritePost *.js silent !standard --fix %
: autocmd BufWritePost *.js redraw!
:augroup END

:augroup auto_format_css
: autocmd!
: autocmd BufWritePost *.css silent !csscomb -c ~/.csscomb.json %
:augroup END

" fzf settings
" jump to the existing window/tab if possible
let g:fzf_buffers_jump = 1
let g:fzf_action = {
  \ 'ctrl-t': 'tab drop',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
" Use urxvt instead
let g:fzf_launcher = 'urxvt -geometry 120x30 -e sh -c %s'

" redude <esc> delay
" ref: http://www.johnhawthorn.com/2012/09/vi-escape-delays/
set timeoutlen=1000 ttimeoutlen=0

let g:closetag_filenames = "*.html,*.xml,*.js,*.jsx"

let g:jsx_ext_required = 0

let g:far#window_layout = "tab"
let g:far#auto_preview = 0
let g:far#source = 'vimgrep'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VISUAL SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" set color scheme
colorscheme mac_classic

" disable SignColumn
set signcolumn=no

" set ruler at 80th column
set colorcolumn=80
set textwidth=80
highlight ColorColumn ctermbg=254

" show line number
set number

" number of visual spaces per TAB
set tabstop=2

" number of spaces in tab when editing
set softtabstop=2

" set indent size
set shiftwidth=2

" tabs are spaces
set expandtab

" show command in bottom bar
set showcmd

" show status bar by default
set laststatus=2

" always show tab line
set showtabline=2

" visual autocomplete for command menu
set wildmenu

" color matching [{()}]
set showmatch

" color search matches
set hlsearch

" wrap text
set wrap linebreak
set breakindent
set showbreak=»»
set textwidth=0 wrapmargin=0

" set custom create fold text function
set foldtext=GenFoldText()

" LightLine settings
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste', 'keymap'],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightLineFugitive',
      \   'readonly': 'LightLineReadonly',
      \   'modified': 'LightLineModified',
      \   'keymap': 'LightLineKeyMap'
      \ },
      \ 'tab_component_function': {
      \   'filename': 'LightLineTabFilename',
      \ },
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag',
      \ },
      \ 'component_type': {
      \   'syntastic': 'error',
      \ },
      \ 'separator': { 'left': ' ', 'right': ' ' },
      \ 'subseparator': { 'left': ' ', 'right': '' }
      \ }


" ListToggle settings
" set height of location/quick list window
let g:lt_height = 3

" display whitespace chars
set list listchars=trail:·,tab:»\ 

" custom syntastic error color
hi SpellBad ctermfg=White ctermbg=Red
hi SpellCap ctermfg=White ctermbg=Red

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.vim/plugged')

Plug 'terryma/vim-multiple-cursors'
Plug 'lilydjwg/colorizer'
Plug 'pangloss/vim-javascript'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'chaoren/vim-wordmotion'
Plug 'tpope/vim-fugitive'
Plug 'sickill/vim-pasta'
Plug 'othree/html5.vim'
Plug 'alvan/vim-closetag'
Plug 'mxw/vim-jsx'
Plug 'itchyny/lightline.vim'
Plug 'brooth/far.vim'

" Add plugins to &runtimepath
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" KEY SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" <f2> to toggle paste mode
set pastetoggle=<F2>

" move vertically by visual line
nmap j gj
nmap k gk

" move to beginning/end of line
nnoremap B ^
nnoremap E $

" $/^ doesn't do anything
" nnoremap $ <nop>
" nnoremap ^ <nop>

" <ctr><q> works as <ctrl><y> to scroll buffer up
nnoremap <C-j> <C-e>
nnoremap <C-k> <C-y>

" space to open/close folds
nnoremap <space> zMzvzz

" <leader><space> to turn off search color
nnoremap <leader><space> :nohlsearch<CR>

" <ctrl><w> to close the current buffer
nnoremap <C-w> :bdelete<CR>

" <ctrl><t> to open some file in a new tab
nnoremap <C-t> :tab drop ./

" allow saving of files as sudo
cmap w!! w !sudo tee > /dev/null %

" <ctrl><p> to fzf
nnoremap <C-p> :FZF<CR>

" <ctrl><jklh> to navigate to splits
execute "set <M-J>=\ej"
nnoremap <M-J> <C-W><C-J>
execute "set <M-K>=\ek"
nnoremap <M-K> <C-W><C-K>
execute "set <M-L>=\el"
nnoremap <M-L> <C-W><C-L>
execute "set <M-H>=\eh"
nnoremap <M-H> <C-W><C-H>

" mappings to move lines
" ref: http://vim.wikia.com/wiki/Moving_lines_up_or_down
" nnoremap <S-j> :m .+1<CR>==
" nnoremap <S-k> :m .-2<CR>==
" vnoremap <S-j> :m '>+1<CR>gv=gv
" vnoremap <S-k> :m '<-2<CR>gv=gv
nnoremap <S-j> <nop>
nnoremap <S-k> <nop>
vnoremap <S-j> <nop>
vnoremap <S-k> <nop>

" remap <o> to avoid hanging
nnoremap <o> <S-A><CR><i>

" <ctrl><s> to save file
nnoremap <C-S> <esc>:w<CR>
inoremap <C-S> <esc>:w<CR>

" <ctrl><a> to select all
nnoremap <C-A> gg<S-V><S-G>

" <ctrl><r> to search in the current file
nnoremap <c-r> :BLines<cr>

" <ctrl><v> to paste in normal and insert mode
nnoremap <c-v> <f2>p<f2>
inoremap <c-v> <esc><f2>p<f2>i

" <ctrl><shift><u> to redo
nnoremap <c-s-u> <c-r>

" <alt><z> to toggle vietnamese-telex keymap
execute "set <m-z>=\ez"
nnoremap <m-z> :call ToggleKeymapVietnamese()<cr>
inoremap <m-z> <esc>:call ToggleKeymapVietnamese()<cr>i

" <f5> to reload current file
nnoremap <F5> :edit<cr>

" <f10> to open vimrc
nnoremap <f10> :tab drop ~/.vimrc<cr>

" center window after <n> and <N>
nnoremap n nzz
nnoremap N Nzz

" <o> and <O> without insert mode
nnoremap o o<esc>
nnoremap O O<esc>

" disable mapping on <f1>
nnoremap <f1> <nop>
inoremap <f1> <nop>
vnoremap <f1> <nop>

" Mapping to easily underline markdown headers
" ref: https://coderwall.com/p/skqpxq/easy-underlining-of-markdown-headings-in-vim
map <leader>mh yypVr-
map <leader>mH yypVr=

" short way to create a dir
nnoremap <c-d> :!mkdir ./

" shortcut key to search and replace
nnoremap <leader>f :F 
nnoremap <leader>F :Far

vnoremap <leader>s :call SortLinesByLengthDesc()<cr><cr>
