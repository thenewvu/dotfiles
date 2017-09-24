" BEHAVIOR SETTINGS
" -----------------

let g:mapleader = ";"
set dir=$HOME/.vim/tmp/
set nobackup
set noswapfile
set undofile
set undodir=~/.vim/undodir
" do replacing globally by default
set gdefault
syntax enable
" ask to confirm closing an unsaved file
set confirm
" switch between buffers without saving
set hidden
" more powerful completion
set completeopt=longest,menuone,preview
" default encoding to utf-8
set encoding=utf-8
" use the system clipboard when yank something
set clipboard^=unnamedplus,unnamed
" autoreload files on change
set autoread
" make backspace work like most other apps
set backspace=indent,eol,start
" ignore case in searching
set ignorecase
" search with smart case
set smartcase
set lazyredraw
set ttyfast
set incsearch
" <esc> delay
set timeoutlen=400 ttimeoutlen=0
set number
set noshowcmd
set noshowmode
set laststatus=1
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set wildmenu
set showmatch
set hlsearch
set wrap linebreak
set breakindent
set textwidth=0
set showbreak=↳\ 
set listchars+=tab:»\ ,trail:•
set list
" disable netrw
let g:loaded_netrwPlugin = 1
let g:loaded_matchparen=1

augroup AutoMisc
  au!
  au BufWritePost .vimrc source %
  au BufWritePost bspwmrc !pkill -TERM -x bspwmrc
  au BufWritePost bspwmrc !%
  au BufWritePost sxhkdrc !pkill -TERM -x sxhkd
  au BufWritePost sxhkdrc !sxhkd&
  au BufWritePost .Xresources !xrdb "%:p"
  au FileType qf resize 3
augroup END

" KEY SETTINGS
" ------------
nnoremap <leader>e :e 
nnoremap <F2> :e ~/.vimrc<CR>
nnoremap <F10> :so ~/.vimrc<CR>
" jump to begin/end of lines
nnoremap B ^
nnoremap E $
" keep the cursor always be vertical center
nnoremap G Gzz
vnoremap G Gzz
nnoremap n nzz
nnoremap N Nzz
nnoremap j gjzz
nnoremap k gkzz
vnoremap j gjzz
vnoremap k gkzz
" insert new line without entering insert mode
nnoremap o o<esc>
nnoremap O O<esc>
" break/join lines
nnoremap J i<enter><esc>
nnoremap K J
" nevigate between buffers
nnoremap gn <C-^>
nnoremap gt :bnext<cr>
nnoremap gT :bprev<cr>
" redo
nnoremap U <c-r>zz
" clear matching
nnoremap <leader><space> :let @/ = ""<CR>
" close current buffer
nnoremap <leader>x :bd<CR>
" underline markdown headers
" ref: https://goo.gl/6zf93B
nnoremap <leader>mh yypVr-
nnoremap <leader>mhh yypVr=
" reload current file and redraw
nnoremap <f5> :edit<cr>:redraw<cr>
" write current file with sudo
cmap w! w !sudo tee > /dev/null %
" navigate between splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" run a shell command
nnoremap ! :! 
" identify the syntax highlighting group used at the cursor
" http://vim.wikia.com/wiki/VimTip99
map <leader>ie :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
" move left/right one indent
nnoremap > >>
nnoremap < <<

" PLUGIN SETTINGS
" ---------------

call plug#begin('~/.vim/plugged')
" color scheme
Plug 'NLKNguyen/papercolor-theme'
set rtp+=~/.vim/plugged/papercolor-theme
set background=light
let g:PaperColor_Theme_Options = {
  \   'theme': {
  \     'default.light': {
  \       'transparent_background': 1
  \     }
  \   }
  \ }
colorscheme PaperColor
" sublime-liked multiple cursors
Plug 'terryma/vim-multiple-cursors'
" improved javascript syntax
Plug 'pangloss/vim-javascript'
" jsx syntax
Plug 'MaxMEllon/vim-jsx-pretty'
hi! link jsxCloseTag jsxTag
hi! link jsxCloseString jsxTag
" commenting
Plug 'tomtom/tcomment_vim'
" automatically add end bracket/quote
Plug 'jiangmiao/auto-pairs'
" fuzzy search files
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" fuzzy search file in the pwd
nnoremap <leader>p :FZF<CR>
" fuzzy search text in the current buffer
nnoremap / :BLines<cr>
nnoremap <leader>/ /
" wb word by word
Plug 'chaoren/vim-wordmotion'
" automatically add end tag
Plug 'alvan/vim-closetag'
let g:closetag_filenames = "*.html,*.xml,*.js,*.jsx"
" search/replace with preview and undoable
Plug 'brooth/far.vim'
let g:far#window_layout = "current"
let g:far#auto_preview = 0
set wildignore+=**/node_modules/**,**/build/**,**/Build/**
nnoremap <leader>f :F 
nnoremap <leader>r :Far 
Plug 'ervandew/supertab'
let g:SuperTabDefaultCompletionType = "context"
" seamlessly working with tmux
Plug 'christoomey/vim-tmux-navigator'
" async linting
Plug 'w0rp/ale'
let g:ale_linters = {}
let g:ale_fixers = {}
let g:ale_linters['javascript'] = ['eslint']
let g:ale_fixers['javascript'] = ['eslint']
let g:ale_javascript_eslint_executable = 'eslint_d'
let g:ale_javascript_eslint_use_global = 1
let g:ale_fix_on_save = 1
let g:ale_set_quickfix = 0
let g:ale_open_list = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_filetype_changed = 0
let g:ale_warn_about_trailing_whitespace = 0
let g:ale_sign_error = '✗ '
let g:ale_sign_warning = '⚠ '
hi! ALEErrorSign ctermbg=none ctermfg=red
hi! ALEWarningSign ctermbg=none ctermfg=yellow
hi! SignColumn ctermbg=none
" previews hex, rgb
Plug 'chrisbra/Colorizer'
Plug 'elzr/vim-json'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme='sol'
let w:airline_skip_empty_sections = 1
let g:airline_powerline_fonts = 1
let g:airline_section_y = ''
let g:airline_section_z = ''
let g:airline_skip_empty_sections = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#wordcount#enabled = 0
let g:airline#extensions#whitespace#enabled = 0
let g:airline_mode_map = {
    \ '__' : '-',
    \ 'n'  : 'N',
    \ 'i'  : 'I',
    \ 'R'  : 'R',
    \ 'c'  : 'C',
    \ 'v'  : 'V',
    \ 'V'  : 'V',
    \ '' : 'V',
    \ 's'  : 'S',
    \ 'S'  : 'S',
    \ '' : 'S',
    \ }
Plug 'edkolev/tmuxline.vim'
let g:tmuxline_preset = {
    \'a'       : '',
    \'b'       : '',
    \'c'       : '',
    \'win'     : '#W',
    \'cwin'    : '#W',
    \'x'       : '',
    \'y'       : '',
    \'z'       : '',
    \'options' : {'status-justify' : 'left'}}
Plug 'Yggdroot/indentLine'
let g:indentLine_char = '¦'
let g:indentLine_first_char = '¦'
let g:indentLine_showFirstIndentLevel = 1
call plug#end()
