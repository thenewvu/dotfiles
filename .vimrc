""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BEHAVIOR SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set leader to ;
let g:mapleader = ";"
" set tmp dir
set dir=$HOME/.vim/tmp/
" disable backup and swap files
set nobackup
set noswapfile
" do replacing globally by default
set gdefault
" enable syntax processing
syntax enable
" display a confirm dialog when closing an unsaved file
set confirm
" enable switching between buffers without saving
set hidden
" switch to existing tab then window when switching buffer
set switchbuf=usetab
" better completion
set completeopt=longest,menuone,preview
" default directions for creating split windows
set splitbelow
set splitright
" set default encoding to utf-8
set encoding=utf-8
" use the system clipboard when yank something
set clipboard^=unnamedplus,unnamed
" autoreload when files are changed outside of vim
set autoread
" make backspace work like most other apps
set backspace=indent,eol,start
" enable mouse interactive
" set mouse=a
" ignore case in searching
set ignorecase
" search with smart case
set smartcase
" Don't redraw when we don't have to
set lazyredraw
" Send more characters at a given time
set ttyfast
" enable incremental searching
set incsearch
" redude <esc> delay
set timeoutlen=1000 ttimeoutlen=0
" enable folding
set foldenable
" set folding method to `syntax`
set foldmethod=syntax
" only fold the first level
set foldnestmax=100 foldlevel=0
" enable folding for javascript syntax
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
" keep undo history across sessions, by storing in file.
silent !mkdir ~/.config/nvim/backups > /dev/null 2>&1
set undodir=~/.config/nvim/backups
set undofile

" autocmd for some types of file
augroup auto
  autocmd!
  autocmd BufWritePost .vimrc source % | AirlineRefresh
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VISUAL SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set default colorscheme
colorscheme slate
" don't show line number column
set nonumber
" set number of visual spaces per TAB
set tabstop=2
" set number of spaces in tab when editing
set softtabstop=2
" set indent size
set shiftwidth=2
" convert tabs are spaces automatically
set expandtab
" show command in bottom bar
set showcmd
" show status bar
set laststatus=2
" always show tab bar
set showtabline=2
" show autocomplete for command menu
set wildmenu
" show color for matching brackets
set showmatch
" show color for search matches
set hlsearch
" wrap long lines without breaking words
set wrap linebreak
set breakindent
set textwidth=0
set wrapmargin=0
" always show the current editing mode
set showmode
" visualize whitespace chars
set showbreak=↪\ \ 
set listchars+=tab:»\ ,trail:•
set list

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" KEY SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" key mapping to toggle paste mode
set pastetoggle=<F2>
" key mappings to jump to begin/end of lines
nnoremap B ^
nnoremap E $
" key mapping to insert new line without entering insert mode
nnoremap o o<esc>
nnoremap O O<esc>
" key mapping to redo
nnoremap U <c-r>zz
" overwrite key mappings to centerize highlighted search
nnoremap n nzzzv
nnoremap N Nzzzv
" key mappings to navigate buffers
nnoremap gt :bn<cr>
nnoremap gT :bp<cr>
" overwrite key mappings to make the caret always be middle
nnoremap j gjzz
nnoremap k gkzz
vnoremap j gjzz
vnoremap k gkzz
" key mapping to unfold current block and close other blocks
nnoremap <space> zMzvzz
" key mapping to clear highlighing search marches
nnoremap <leader><space> :nohlsearch<CR>
" key mapping to underline markdown headers
" ref: https://goo.gl/6zf93B
nnoremap <leader>mh yypVr-
nnoremap <leader>mH yypVr=
" key mapping to reload current file then force to redraw
nnoremap <f5> :edit<cr>:redraw<cr>
" key mapping to write current file with sudo
cmap w!! w !sudo tee > /dev/null %
" key mapping to close the current buffer
nnoremap <leader>x :bd<cr>
" key mapping to edit a file
nnoremap <leader>e :e 
" key mappings to navigate between splits in normal mode
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" disable noisy keys
nnoremap J <nop>
nnoremap K <nop>
" key mapping to run a shell command
nnoremap ! :! 


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')
" plugin provides sublime-liked multiple cursors
Plug 'terryma/vim-multiple-cursors'
" plugin provides javascript syntax highlight
Plug 'pangloss/vim-javascript', {'frozen': 1, 'commit': 'aba8630e2f42021c8859a1a99aa1b1c823fc5616'}
Plug 'MaxMEllon/vim-jsx-pretty'
" plugin provides commenting
Plug 'tomtom/tcomment_vim'
" plugin automatically adds close bracket/quote
Plug 'jiangmiao/auto-pairs'
" plugin to fuzzy search files/texts
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" key mapping to fuzzy search file in the current working dir
nnoremap <leader>p :FZF<CR>
" key mapping to fuzzy search text in the current buffer
nnoremap <leader>r :BLines<cr>
" plugin allows to <w>/<b> over words
Plug 'chaoren/vim-wordmotion'
" plugin provides git functions, only required by airline so far
Plug 'tpope/vim-fugitive'
" plugin provides html5 syntax highlight
Plug 'othree/html5.vim'
" plugin automatically adds close tag
Plug 'alvan/vim-closetag'
let g:closetag_filenames = "*.html,*.xml,*.js,*.jsx"
" plugin allows to search/replace with preview and undoable
Plug 'brooth/far.vim'
let g:far#window_layout = "current"
let g:far#auto_preview = 0
set wildignore+=**/node_modules/**,**/build/**,**/Build/**
nnoremap <leader>f :F
nnoremap <leader>ff :Far
" plugin provides powerline-liked status line and tab line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme = 'base16_grayscale'
let g:airline_powerline_fonts = 1
" Show just the line and column number in section z
let g:airline_section_z = '%l:%v'
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#wordcount#enabled = 0
let g:airline_skip_empty_sections = 1
" enabled showing buffers on tabline
let g:airline#extensions#tabline#enabled = 1
" set filename mode to relative without being collapsed
let g:airline#extensions#tabline#fnamemod = ':.'
let g:airline#extensions#tabline#fnamecollapse = 0
" plugin allows to select completion entries by tabbing
Plug 'ervandew/supertab' 
let g:SuperTabDefaultCompletionType = "context"
" Plugin provides color scheme
Plug 'pbrisbin/vim-colors-off'
set rtp+=~/.vim/plugged/vim-colors-off
set background=dark
colorscheme off
" plugin provides seamlessly key mappings working with tmux
Plug 'christoomey/vim-tmux-navigator'
" plugin provides async linting
Plug 'w0rp/ale'
let g:ale_linters = {}
let g:ale_linters['javascript'] = ['eslint']
let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['prettier']
let g:ale_javascript_eslint_executable = 'eslint_d'
let g:ale_javascript_eslint_use_global = 1
let g:ale_javascript_prettier_executable = 'prettier_d'
let g:ale_javascript_prettier_use_global = 1
let g:ale_javascript_prettier_options = '--no-semi --single-quote'
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
" plugin generates tmux theme that bases on the current airline
Plug 'edkolev/tmuxline.vim'
let g:tmuxline_powerline_separators = 1
" plugin provides some essential git functions
Plug 'jreybert/vimagit'
nnoremap <leader>gm :MagitOnly<cr>
" plugin provides git log browser
Plug 'kablamo/vim-git-log'
nnoremap <leader>gl :GitLog<cr>
" plugin previews hex, rgb, x11 colors
Plug 'chrisbra/Colorizer'
call plug#end()
