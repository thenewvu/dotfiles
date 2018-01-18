" BEHAVIOR SETTINGS
" -----------------
set termguicolors
syntax enable
" point %% to the current the full page of the directory that containts the
" current editing file
" Ref: http://vim.wikia.com/wiki/Easy_edit_of_files_in_the_same_directory
cabbr <expr> %% expand('%:p:h')
" set working dir
set directory=$HOME/.vim/tmp/
" no junk files
set nobackup
set nowritebackup
set noswapfile
" persist undo history
set undodir=~/.vim/undo
set undofile
set undolevels=1000
set undoreload=10000
" Disable the startup message
set shortmess=I                
set shortmess+=a
" Keep cursor in the same place after saves
set nostartofline              
" more natural split opening
set splitbelow
set splitright
" do replacing globally by default
set gdefault
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
set incsearch
" smaller <esc> delay
set timeoutlen=400 
set ttimeoutlen=0
set number
set noshowcmd
set noshowmode
set laststatus=2
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set wildmenu
set wildmode=longest,list
set showmatch
set hlsearch
set breakindent
set showbreak=↳\ 
set nolist
set nowrap
set smartcase
set ignorecase

" syntax highlight only first 120 columns
set synmaxcol=120
" disable netrw by faking it was loaded
let g:loaded_netrwPlugin = 1
" disable auto matching parens by faking it was loaded
let g:loaded_matchparen=1
set lazyredraw
set ttyfast

set foldenable
set foldmethod=syntax
set foldnestmax=5
set foldlevel=0 
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
set fillchars+=fold:\ 
" Ref: http://vim.wikia.com/wiki/Folding_for_plain_text_files_based_on_indentation
set foldtext=MyFoldText()
function! MyFoldText()
	let line = getline(v:foldstart)
	" Foldtext ignores tabstop and shows tabs as one space,
	" so convert tabs to 'tabstop' spaces so text lines up
	let ts = repeat(' ',&tabstop)
	return substitute(line, '\t', ts, 'g')
endfunction
augroup auto_cmds
  au!
  au FileType groovy setlocal tabstop=4 softtabstop=4 shiftwidth=4
  au FileType markdown setlocal textwidth=79 linebreak wrap
  au FileType qf set nobuflisted
  au BufWritePost .vimrc source %
  au BufWritePost .chunkwmrc !brew services restart chunkwm
  au BufWritePost .skhdrc !brew services restart skhd
augroup END

" KEY SETTINGS
" ------------
let g:mapleader = ";"
nnoremap <leader>e :e 
nnoremap <F2> :e ~/.vimrc<CR>
nnoremap <F10> :so ~/.vimrc<CR>
" correct indent after paste
nnoremap p p=`]
" no more Ex mode
nnoremap Q <nop>
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
" Ref: https://goo.gl/6zf93B
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
tnoremap <C-h> <C-w>h
tnoremap <C-j> <C-w>j
tnoremap <C-k> <C-w>k
tnoremap <C-l> <C-w>l
inoremap <C-h> <C-w>h
inoremap <C-j> <C-w>j
inoremap <C-k> <C-w>k
inoremap <C-l> <C-w>l
" run a shell command
nnoremap ! :! 
" move left/right one indent
nnoremap > >>
nnoremap < <<
" <ecs> to escape temrinal mode
tnoremap <Esc> <C-\><C-n>



" PLUGIN SETTINGS
" ---------------
call plug#begin('~/.vim/plugged')
Plug 'thenewvu/vim-colors-blueprint'
set rtp+=~/.vim/plugged/vim-colors-blueprint
colorscheme blueprint
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
Plug 'Raimondi/delimitMate'
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
let g:far#source = "agnvim"
let g:far#window_layout = "current"
let g:far#file_mask_favorites = ["%", ".js", ".go", ".css", ".html"]
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
Plug 'gabrielelana/vim-markdown', { 'for': 'markdown' }
let g:markdown_enable_spell_checking = 0
let g:markdown_enable_insert_mode_mappings = 0
let g:markdown_enable_conceal = 1
Plug 'ap/vim-buftabline'
let g:buftabline_indicators = 1
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'edkolev/tmuxline.vim'
let g:tmuxline_powerline_separators = 0
let g:tmuxline_theme = 'vim_statusline_1'
let g:tmuxline_preset = {
  \ 'win': '#W',
  \ 'cwin': '#W#F',
  \ 'options': {
  \   'status-justify': 'left'}
  \}
call plug#end()
