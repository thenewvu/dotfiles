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
set timeoutlen=1000 ttimeoutlen=0
set foldenable
set foldmethod=syntax
set foldnestmax=100 foldlevel=0
let javaScript_fold=1
set foldtext=FoldText()
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

augroup auto
  autocmd!
  autocmd BufWritePost .vimrc source %
  autocmd BufWritePost bspwmrc !%
  autocmd BufWritePost sxhkdrc !pkill -USR1 -x sxhkd
  autocmd BufWritePost .Xresources !xrdb "%:p"
  autocmd FileType qf resize 3
augroup END

" http://vim.wikia.com/wiki/Faster_loading_of_large_files
" file is large from 500 kb
let g:LargeFile = 1024 * 500
augroup LargeFile
 autocmd BufReadPre * let f=getfsize(expand("<afile>")) | if f > g:LargeFile || f == -2 | call LargeFile() | endif
augroup END

function! LargeFile()
 " no syntax highlighting etc
 set eventignore+=FileType
 " save memory when other file is viewed
 setlocal bufhidden=unload
 " is read-only (write with :w new_filename)
 setlocal buftype=nowrite
 " no undo possible
 setlocal undolevels=-1
 " display message
 autocmd VimEnter *  echo "The file is larger than " . (g:LargeFile / 1024 ) . " KB, so some options are changed (see .vimrc for details)."
endfunction

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
set showbreak=↪\ \ 
set listchars+=tab:»\ ,trail:•
set list


" KEY SETTINGS
" ------------

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
nnoremap w wzz
nnoremap b bzz
vnoremap w wzz
vnoremap b bzz
" insert new line without entering insert mode
nnoremap o o<esc>
nnoremap O O<esc>
" break/join lines
nnoremap J i<enter>
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
cmap w!! w !sudo tee > /dev/null %
" close the current buffer if not the last
nnoremap <leader>x :b#\|bd #<cr>
" navigate between splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" run a shell command
nnoremap ! :! 


" PLUGIN SETTINGS
" ---------------

call plug#begin('~/.vim/plugged')
" sublime-liked multiple cursors
Plug 'terryma/vim-multiple-cursors'
" improved javascript syntax
Plug 'pangloss/vim-javascript', {'frozen': 1, 'commit': 'aba8630e2f42021c8859a1a99aa1b1c823fc5616'}
" jsx syntax
Plug 'MaxMEllon/vim-jsx-pretty'
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
" color scheme
Plug 'pbrisbin/vim-colors-off'
set rtp+=~/.vim/plugged/vim-colors-off
set background=light
colorscheme off
hi! Normal      ctermbg=none ctermfg=black
hi! Comment     ctermbg=none ctermfg=darkgrey
hi! Visual      ctermbg=none ctermfg=none cterm=underline 
hi! DiffAdd     ctermbg=none ctermfg=none cterm=underline 
hi! DiffDelete  ctermbg=none ctermfg=none cterm=underline 
hi! DiffText    ctermbg=none  cterm=underline
hi! link DiffChange Normal
hi! link Pmenu      Visual
hi! link WildMenu   Visual
hi! link htmlH1     Normal
hi! link htmlH2     Normal
hi! link htmlH3     Normal
hi! link htmlH4     Normal
hi! link htmlH5     Normal
hi! link htmlH6     Normal

" seamlessly working with tmux
Plug 'christoomey/vim-tmux-navigator'
" async linting
Plug 'w0rp/ale'
let g:ale_linters = {}
let g:ale_linters['javascript'] = ['eslint']
let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['prettier']
let g:ale_javascript_eslint_executable = 'eslint_d'
let g:ale_javascript_eslint_use_global = 1
let g:ale_javascript_prettier_executable = 'prettier'
let g:ale_javascript_prettier_use_global = 1
let g:ale_javascript_prettier_options = '--no-semi --single-quote --print-width=65'
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
highlight ALEErrorSign ctermbg=none ctermfg=red
highlight ALEWarningSign ctermbg=none ctermfg=yellow
highlight SignColumn ctermbg=none
" enhanced git commit
Plug 'jreybert/vimagit'
nnoremap <leader>gm :MagitOnly<cr>
" git log browser
Plug 'kablamo/vim-git-log'
nnoremap <leader>gl :GitLog<cr>
" previews hex, rgb
Plug 'chrisbra/Colorizer'
Plug 'ron89/thesaurus_query.vim'
" remove distraction
Plug 'junegunn/goyo.vim'
" start Goyo at vim startup
augroup Goyo autocmd!
  autocmd VimEnter * Goyo 65
  autocmd VimLeave * call s:goyo_leave()
augroup END
function! s:goyo_enter()
  silent !tmux set status on
  set noshowmode
  set noshowcmd
endfunction
function! s:goyo_leave()
  quit
endfunction
autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
call plug#end()
