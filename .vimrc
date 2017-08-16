" BEHAVIOR SETTINGS
" -----------------

let g:mapleader = ";"
set dir=$HOME/.vim/tmp/
set nobackup
set noswapfile
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
set foldenable
set foldmethod=syntax
set foldnestmax=100 foldlevel=0
let javaScript_fold=1
set foldtext=FoldText()
" https://coderwall.com/p/usd_cw/a-pretty-vim-foldtext-function
function! FoldText()
  let l:lpadding = &fdc
  redir => l:signs
  execute 'silent sign place buffer='.bufnr('%')
  redir End
  let l:lpadding += l:signs =~ 'id=' ? 2 : 0

  if exists("+relativenumber")
    if (&number)
      let l:lpadding += max([&numberwidth, strlen(line('$'))]) + 1
    elseif (&relativenumber)
      let l:lpadding += max([&numberwidth, strlen(v:foldstart) + strlen(v:foldstart - line('w0')), strlen(v:foldstart) + strlen(line('w$') - v:foldstart)]) + 1
    endif
  else
    if (&number)
      let l:lpadding += max([&numberwidth, strlen(line('$'))]) + 1
    endif
  endif

  " expand tabs
  let l:start = substitute(getline(v:foldstart), '\t', repeat(' ', &tabstop), 'g')
  let l:end = substitute(substitute(getline(v:foldend), '\t', repeat(' ', &tabstop), 'g'), '^\s*', '', 'g')

  let l:info = ' (' . (v:foldend - v:foldstart) . ')'
  let l:infolen = strlen(substitute(l:info, '.', 'x', 'g'))
  let l:width = winwidth(0) - l:lpadding - l:infolen

  let l:separator = ' … '
  let l:separatorlen = strlen(substitute(l:separator, '.', 'x', 'g'))
  let l:start = strpart(l:start , 0, l:width - strlen(substitute(l:end, '.', 'x', 'g')) - l:separatorlen)
  let l:text = l:start . ' … ' . l:end

  return l:text . repeat(' ', l:width - strlen(substitute(l:text, ".", "x", "g"))) . l:info
endfunction

" keep undo history across sessions by storing in file.
silent !mkdir ~/.config/nvim/backups > /dev/null 2>&1
set undodir=~/.config/nvim/backups
set undofile

augroup AutoResource
  autocmd!
  autocmd BufWritePost .vimrc source %
  autocmd BufWritePost bspwmrc !%
  autocmd BufWritePost sxhkdrc !pkill -USR1 -x sxhkd
  autocmd BufWritePost .Xresources !xrdb "%:p"
  autocmd FileType qf resize 3
augroup END

" VISUAL SETTINGS
" ---------------
" hide line number column
set nonumber
set tabstop=2
set softtabstop=2
set shiftwidth=2
" tabs as spaces
set expandtab
set showcmd
" show status bar
set laststatus=2
" autocomplete for command menu
set wildmenu
" show paird brackets
set showmatch
" show matched results in searching
set hlsearch
" wrap lines without breaking words
set wrap linebreak
set breakindent
set textwidth=0
set wrapmargin=0
" show the current editing mode
set showmode
" visualize whitespace chars
set showbreak=»\ 
set listchars+=tab:»\ ,trail:•
set list


" KEY SETTINGS
" ------------
" quictly exit vim
nnoremap <leader>q :q<cr>
" open new file
nnoremap <leader>e :e 
" edit vimrc
nnoremap <F2> :e ~/.vimrc<CR>
" jump to begin/end of lines
nnoremap B ^
nnoremap E $
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
" redo
nnoremap U <c-r>zz
" navigate between buffers
nnoremap gt :bn<cr>
nnoremap gT :bp<cr>
" unfold current block and close others
nnoremap <space> zMzvzz
" clear matching
nnoremap <leader><space> :nohlsearch<CR>
" underline markdown headers
" ref: https://goo.gl/6zf93B
nnoremap <leader>mh yypVr-
nnoremap <leader>mhh yypVr=
" reload current file and redraw
nnoremap <f5> :edit<cr>:redraw<cr>
" write current file with sudo
cmap w! w !sudo tee > /dev/null %
" close the current buffer if not the last
nnoremap <leader>x :bd<cr>
" navigate between splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" run a shell command
nnoremap ! :! 
" identify the syntax highlighting group used at the cursor
" http://vim.wikia.com/wiki/VimTip99
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
" move left/right one indent
nnoremap > >>
nnoremap < <<


" PLUGIN SETTINGS
" ---------------

call plug#begin('~/.vim/plugged')
" color scheme
Plug 'morhetz/gruvbox'
set rtp+=~/.vim/plugged/gruvbox
set background=dark
colorscheme gruvbox
hi! link Folded Normal
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_invert_selection = 0
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
let g:fzf_buffers_jump = 1
" fuzzy search file in the pwd
nnoremap <leader>p :FZF<CR>
" fuzzy search text in the current buffer
nnoremap / :BLines<cr>
nnoremap <leader>/ /
" wb word by word
Plug 'chaoren/vim-wordmotion'
" git functions
Plug 'tpope/vim-fugitive'
" html5 syntax
Plug 'othree/html5.vim'
" automatically add end tag
Plug 'alvan/vim-closetag'
let g:closetag_filenames = "*.html,*.xml,*.js,*.jsx"
" search/replace with preview and undoable
Plug 'brooth/far.vim'
let g:far#window_layout = "current"
let g:far#auto_preview = 0
set wildignore+=**/node_modules/**,**/build/**,**/Build/**
" search
nnoremap <leader>f :F 
" replace
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
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_filetype_changed = 0
let g:ale_warn_about_trailing_whitespace = 0
let g:ale_sign_error = '✗ '
let g:ale_sign_warning = '⚠ '
let g:airline_section_error = '%{ale#statusline#Status()}'
hi! ALEErrorSign ctermbg=none ctermfg=red
hi! ALEWarningSign ctermbg=none ctermfg=yellow
hi! SignColumn ctermbg=none
" enhanced git commit
Plug 'jreybert/vimagit'
nnoremap <leader>gm :MagitOnly<cr>
" git log browser
Plug 'kablamo/vim-git-log'
nnoremap <leader>gl :GitLog<cr>
" previews hex, rgb
Plug 'chrisbra/Colorizer'
" search thesaurus
Plug 'ron89/thesaurus_query.vim'
" powerline-liked status/tab bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme = 'gruvbox'
let g:airline_section_z = '%l:%v'
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#wordcount#enabled = 0
let g:airline_skip_empty_sections = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':.'
let g:airline#extensions#tabline#fnamecollapse = 0
let g:airline_powerline_fonts = 1
" generates tmux theme that matches then current airline theme
Plug 'edkolev/tmuxline.vim'
let g:tmuxline_powerline_separators = 1
let g:tmuxline_preset = 'tmux'
" speed up opening huge files which by default bigger than 2MB
Plug 'mhinz/vim-hugefile'
call plug#end()
