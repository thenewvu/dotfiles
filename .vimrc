" BEHAVIOR SETTINGS
" -----------------

let g:mapleader = ";"
set dir=$HOME/.vim/tmp/
set nobackup
set noswapfile
set undofile
set undodir=$HOME/.vim/undodir
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
set nonumber
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
set breakindent
set showbreak=↳\ 
set listchars=tab:»\ ,trail:•
set nolist
set nowrap
set foldenable
set foldmethod=syntax
set foldnestmax=100
set foldlevel=0 
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
set fillchars+=fold:\ 
" http://vim.wikia.com/wiki/Folding_for_plain_text_files_based_on_indentation
set foldtext=MyFoldText()
function! MyFoldText()
	let line = getline(v:foldstart)
	" Foldtext ignores tabstop and shows tabs as one space,
	" so convert tabs to 'tabstop' spaces so text lines up
	let ts = repeat(' ',&tabstop)
	return substitute(line, '\t', ts, 'g')
endfunction
" disable netrw
let g:loaded_netrwPlugin = 1
" disable matching parens
let g:loaded_matchparen=1
augroup auto_cmds
  au!
  au FileType groovy setlocal tabstop=4 softtabstop=4 shiftwidth=4
  au FileType markdown setlocal textwidth=79 linebreak
augroup END

" KEY SETTINGS
" ------------
nnoremap <leader>e :e 
nnoremap <F2> :e ~/.vimrc<CR>
nnoremap <F10> :so ~/.vimrc<CR>
" jump to begin/end of lines
nnoremap B ^
nnoremap E $
" key mapping to unfold current block and close other blocks
nnoremap <space> zMzvzz
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
" navigate between buffers
nnoremap <silent> <C-w><C-w> <C-w><C-w>:if &buftype ==# 'quickfix'<Bar>wincmd w<Bar>endif<CR>
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
" move left/right one indent
nnoremap > >>
nnoremap < <<

" PLUGIN SETTINGS
" ---------------

call plug#begin('~/.vim/plugged')
Plug 'chriskempson/vim-tomorrow-theme'
set rtp+=~/.vim/plugged/vim-tomorrow-theme
set background=light
colorscheme tomorrow
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
let g:far#auto_preview = 1
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
let g:ale_set_quickfix = 1
let g:ale_open_list = 1
let g:ale_list_window_size = 3
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
Plug 'gabrielelana/vim-markdown'
let g:markdown_enable_spell_checking = 0
let g:markdown_enable_insert_mode_mappings = 0
let g:markdown_enable_conceal = 1
Plug 'ap/vim-buftabline'
let g:buftabline_indicators = 1
hi! link BufTabLineCurrent Normal
hi! link BufTabLineActive Comment
hi! link BufTabLineHidden Comment
hi! link BufTabLineFill Comment
Plug 'fatih/vim-go'
call plug#end()
