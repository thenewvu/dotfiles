" BEHAVIOR SETTINGS
" -----------------

" enable term-true-color, requires terminal support
" https://gist.github.com/XVilka/8346728
if has("termguicolors")
  set termguicolors
endif

" enable syntax highlight 
syntax on

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
set undolevels=100
set undoreload=100

" split by default below and right
set splitbelow
set splitright

" ask to confirm closing an unsaved file
set confirm

" switch between buffers without saving
set hidden

" better completion
" .: Scan the current buffer
" w: Scan buffers from other windows
" b: Scan buffers from the buffer list
" u: Scan buffers that have been unloaded from the buffer list
" t: Tag completion
" i: Scan the current and included files
set complete-=i
set complete-=t
set completeopt=menuone,preview

" default encoding to utf-8
set encoding=utf-8

" use the system clipboard when yank something
set clipboard^=unnamedplus,unnamed

" autoreload files on change
set autoread

" make backspace work like most other apps
set backspace=indent,eol,start

" highlight search matching interactively
set incsearch
set hlsearch
set smartcase
set ignorecase

" show preview when replacing with :s
set inccommand=nosplit 

" smaller <esc> delay
set timeoutlen=400
set ttimeoutlen=0

" no line number
set nonumber

" always show status line
set laststatus=2

" tab-related
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set nolist

" show auto-complete when typing in command line
set wildmenu
set wildmode=longest,list
set wildignore+=.hg,.git,.svn

set textwidth=80
set wrap 
set linebreak 
set showbreak=↳\ 

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

" disable netrw by faking it was loaded
let g:loaded_netrwPlugin = 1

" disable auto matching parens by faking it was loaded
let g:loaded_matchparen=1
let g:matchparen_timeout = 2
let g:matchparen_insert_timeout = 2

set noshowcmd
set noshowmode

set lazyredraw
set ttyfast

set synmaxcol=80

" file is large from 500kb
let g:LargeFile = 1024 * 500
augroup LargeFile
  autocmd!
  autocmd BufReadPre * call CheckIfLargeFile("<afile>")
augroup END

" ref: http://vim.wikia.com/wiki/Faster_loading_of_large_files
function! CheckIfLargeFile(file)
  let f=getfsize(expand(a:file))
  if f > g:LargeFile || f == -2
    " no syntax highlighting etc
    set eventignore+=FileType
    " save memory when other file is viewed
    setlocal bufhidden=unload
    " is read-only (write with :w new_filename)
    setlocal buftype=nowrite
    " no undo possible
    setlocal undolevels=-1
  else
    set eventignore-=FileType
  endif
endfunction

" use ripgrep as grepprg if available
if executable('rg')
  set grepprg=rg\ --vimgrep
endif

function! ClampWinHeight(min, max)
  exe max([min([line("$"), a:max]), a:min]) . "wincmd _"
endfunction

augroup QuickFix
  autocmd!
  autocmd QuickFixCmdPost [^l]* nested copen
  autocmd QuickFixCmdPost l*    nested lopen
  autocmd FileType qf set nobuflisted
  autocmd FileType qf call ClampWinHeight(3, 10)
augroup END

augroup Groovy
  autocmd!
  autocmd FileType groovy setlocal tabstop=4 softtabstop=4 shiftwidth=4
augroup END

augroup Vim
  autocmd!
  au BufWritePost .vimrc source %
augroup END

" KEY SETTINGS
" ------------
let g:mapleader = ";"
let g:maplocalleader = "\\"
nnoremap <leader>; : 
nnoremap <leader>e :e 
nnoremap <F2> :e ~/.vimrc<CR>
" no more Ex mode
nnoremap Q <nop>
" jump to begin/end of lines
nnoremap B ^
nnoremap E $
vnoremap B ^
vnoremap E $
" <space> to unfold under caret block and fold others
nnoremap <space> zMzvzz
" keep the cursor always be vertical center
nnoremap G Gzz
vnoremap G Gzz
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap j jzz
nnoremap k kzz
vnoremap j jzz
vnoremap k kzz
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
nnoremap <silent> <leader>q :bp\|bd #<CR>
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
" <f1> won't no longer open vim help
nnoremap <F1> <esc>
inoremap <F1> <esc>
vnoremap <F1> <esc>
" search text in root directory
nnoremap <leader>f :grep 

" PLUGIN SETTINGS
" ---------------
call plug#begin('~/.vim/plugged')

Plug 'lifepillar/vim-wwdc17-theme'
set rtp+=~/.vim/plugged/vim-wwdc17-theme
let g:wwdc17_frame_color = 7
colorscheme wwdc17
hi! Comment guibg=white ctermbg=white
hi! SignColumn guibg=white ctermbg=white
hi! ALEErrorSign guibg=white ctermbg=white

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
augroup FZF
  autocmd!
  " <ecs> doesn't close fzf window because it's in terminal mode,
  " this trick remaps <ecs> in terminal mode
  autocmd TermOpen term://*FZF tnoremap <silent> <buffer><nowait> <esc> <c-c>
augroup end

" wb word by word
Plug 'chaoren/vim-wordmotion'

" automatically add end tag
Plug 'alvan/vim-closetag'
let g:closetag_filenames = "*.html,*.xml,*.js,*.jsx"

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
let g:ale_linters['c'] = ['clang']
let g:ale_linters['cpp'] = ['clang']
let g:ale_fix_on_save = 1
let g:ale_set_signs = 1
let g:ale_sign_error = '⚑'
let g:ale_sign_warning = '⚐'
let g:ale_open_list = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_filetype_changed = 0
let g:ale_warn_about_trailing_whitespace = 0
nmap <silent> [l <Plug>(ale_previous_wrap)
nmap <silent> ]l <Plug>(ale_next_wrap)

" provides a buffer line which looks like the tab line
Plug 'ap/vim-buftabline'
let g:buftabline_indicators = 1
let g:buftabline_plug_map = 0
hi! link BufTabLineCurrent   TabLineSel   " Buffer shown in current window
hi! link BufTabLineActive    TablineSel   " Buffer shown in other window
hi! link BufTabLineHidden    TabLine      " Buffer not currently visible
hi! link BufTabLineFill      TabLineFill  " Empty area

" toolkit for develop golang
Plug 'fatih/vim-go', { 'for': 'go' }

" generate tmux theme that matches the current color scheme
Plug 'edkolev/tmuxline.vim'
let g:tmuxline_powerline_separators = 0
let g:tmuxline_theme = 'vim_statusline_1'
let g:tmuxline_preset = {
  \ 'win': '#W',
  \ 'cwin': '#W#F',
  \ 'options': {
  \   'status-justify': 'left'}
  \}

" likes ! but output into a buffer
Plug 'sjl/clam.vim'
nnoremap !! :!<space>
nnoremap ! :Clam<space>
vnoremap ! :ClamVisual<space>

" allow to edit and save changes in quickfix
Plug 'stefandtw/quickfix-reflector.vim'

Plug 'terryma/vim-multiple-cursors'
hi link multiple_cursors_cursor Cursor
hi link multiple_cursors_visual Search

" provides :Rename command
Plug 'danro/rename.vim'

Plug 'dhruvasagar/vim-table-mode'

Plug 'airblade/vim-gitgutter'
let g:gitgutter_signs = 1
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_diff_args = '-w'
let g:gitgutter_map_keys = 0
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '≢'
let g:gitgutter_sign_removed = '_'
let g:gitgutter_sign_modified_removed = '≠'
" hi link GitGutterAdd DiffAdd
" hi link GitGutterChange DiffChange
" hi link GitGutterChangeDelete DiffChange
" hi link GitGutterDelete DiffDelete
nmap ]d <Plug>GitGutterNextHunk
nmap [d <Plug>GitGutterPrevHunk

call plug#end()
