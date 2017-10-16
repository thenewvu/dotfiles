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
" enable folding
set foldenable
set foldtext=getline(v:foldstart)
set fillchars=stl:\ ,stlnc:\ ,vert:\|,fold:\-,diff:-
" disable netrw
let g:loaded_netrwPlugin = 1
" disable matching parens
let g:loaded_matchparen=1

" KEY SETTINGS
" ------------
nnoremap <leader>e :e 
nnoremap <F2> :e ~/.vimrc<CR>
nnoremap <F10> :so ~/.vimrc<CR>
" jump to begin/end of lines
nnoremap B ^
nnoremap E $
" key mapping to unfold current block and close other blocks
nnoremap <silent> <space> zMzvzz
" keep the cursor always be vertical center
nnoremap G Gzz
vnoremap G Gzz
nnoremap n nzzzv
nnoremap N Nzzzv
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
Plug 'pbrisbin/vim-colors-off'
set rtp+=~/.vim/plugged/vim-colors-off
set background=light
colorscheme off
hi! Normal ctermbg=none ctermfg=31
" sublime-liked multiple cursors
Plug 'terryma/vim-multiple-cursors'
" improved javascript syntax
Plug 'pangloss/vim-javascript'
augroup javascript_folding
    au!
    au FileType javascript setlocal foldmethod=syntax
    au FileType javascript setlocal foldnestmax=100 foldlevel=0
augroup END
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
let g:airline_section_y = ''
let g:airline_section_z = ''
let g:airline_skip_empty_sections = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#fnamemod = ':.'
let g:airline#extensions#tabline#fnamecollapse = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#wordcount#enabled = 0
let g:airline#extensions#whitespace#enabled = 0
Plug 'edkolev/tmuxline.vim'
let g:tmuxline_powerline_separators = 1
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
Plug 'plasticboy/vim-markdown'
let g:vim_markdown_no_extensions_in_markdown = 1
augroup vim_markdown
  au!
  au FileType markdown setlocal conceallevel=2
  au FileType markdown setlocal colorcolumn=80
  au FileType markdown setlocal textwidth=80
augroup END
call plug#end()
