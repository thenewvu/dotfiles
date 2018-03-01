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
" better completion
" .: Scan the current buffer
" w: Scan buffers from other windows
" b: Scan buffers from the buffer list
" u: Scan buffers that have been unloaded from the buffer list
" t: Tag completion
" i: Scan the current and included files
set complete=.,w,b,u,t
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
set wildignore+=.hg,.git,.svn
set showmatch
set hlsearch
set breakindent
set showbreak=↳\ 
set nolist
set nowrap
set smartcase
set ignorecase
" show results while typing a :substitute command
set inccommand=nosplit 

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

" switch cursor from block in insert mode
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This enables iterm cursor changes from vim. In .tmux.conf you'll need:
" set-option -g terminal-overrides '*88col*:colors=88,*256col*:colors=256,xterm*:XT:Ms=\E]52;%p1%s;%p2%s\007:Cc=\E]12;%p1%s\007:Cr=\E]112\007:Cs=\E]50;CursorShape=%?%p1%{3}%<%t%{0}%e%p1%{2}%-%;%d\007'
"
" Source: https://github.com/Casecommons/casecommons_workstation/blob/master/templates/default/dot_tmux.conf.erb
"         https://github.com/Casecommons/vim-config/blob/master/init/tmux.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if exists('$ITERM_PROFILE')
  if exists('$TMUX')
    let &t_SI = "\<Esc>[3 q"
    let &t_EI = "\<Esc>[0 q"
  else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  endif
end

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" treat huge files differently
" ref: http://vim.wikia.com/wiki/Faster_loading_of_large_files
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" file is large from 100kb
let g:LargeFile = 1024 * 100
augroup LargeFile
  autocmd!
  autocmd BufReadPre * call CheckIfLargeFile("<afile>")
augroup END

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

augroup Markdown
  autocmd!
  autocmd FileType markdown setlocal textwidth=79 linebreak wrap
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
noremap  <F1> <esc>
inoremap <F1> <esc>
" search text in root directory
noremap <leader>f :grep 


" PLUGIN SETTINGS
" ---------------
call plug#begin('~/.vim/plugged')
Plug 'thenewvu/vim-colors-sketching'
set rtp+=~/.vim/plugged/vim-colors-sketching
colorscheme sketching
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
augroup FZF
  autocmd!
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
let g:ale_fix_on_save = 1
let g:ale_set_signs = 0
" automatically open quickfix
let g:ale_open_list = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_filetype_changed = 0
let g:ale_warn_about_trailing_whitespace = 0
Plug 'gabrielelana/vim-markdown', { 'for': 'markdown' }
let g:markdown_enable_spell_checking = 0
let g:markdown_enable_insert_mode_mappings = 0
let g:markdown_enable_conceal = 1
Plug 'ap/vim-buftabline'
let g:buftabline_indicators = 1
let g:buftabline_plug_map = 0
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
Plug 'sjl/clam.vim'
nnoremap !! :!<space>
nnoremap ! :Clam<space>
vnoremap ! :ClamVisual<space>
Plug 'airblade/vim-gitgutter'
let g:gitgutter_signs = 1
let g:gitgutter_highlight_lines = 1
let g:gitgutter_diff_args = '-w'
let g:gitgutter_map_keys = 0
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '#'
let g:gitgutter_sign_removed = '_'
let g:gitgutter_sign_modified_removed = '#'
hi link GitGutterAdd DiffAdd
hi link GitGutterChange DiffChange
hi link GitGutterChangeDelete DiffChange
hi link GitGutterDelete DiffDelete
hi link GitGutterAddLine DiffAdd
hi link GitGutterChangeLine DiffChange
hi link GitGutterDeleteLine Normal
hi link GitGutterChangeDeleteLine DiffChange
Plug 'stefandtw/quickfix-reflector.vim'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
call plug#end()
