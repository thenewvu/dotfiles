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
" enable syntax processing
syntax enable
" display a confirm dialog when closing an unsaved file
set confirm
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
" optimize rendering
set lazyredraw
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
" function that returns a cleaner folding text title
" ref: https://goo.gl/Ma7UWE
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
" set a custom folding function
set foldtext=GenFoldText()
" keep undo history across sessions, by storing in file.
silent !mkdir ~/.config/nvim/backups > /dev/null 2>&1
set undodir=~/.config/nvim/backups
set undofile

" function reloads file after reformatted it without changing view status
function! ReloadFileAfterFormatted()
  :mkview | edit | silent! loadview
endf

" autocmd for some types of file
augroup auto
  autocmd!
  autocmd BufWritePost .vimrc source % | AirlineRefresh
  autocmd BufWritePost bspwmrc !%
  autocmd BufWritePost sxhkdrc !pkill -USR1 -x sxhkd
  autocmd TermOpen * setlocal bufhidden=hide
  autocmd BufWinEnter,WinEnter term://* startinsert
  autocmd BufLeave term://* stopinsert
  autocmd FileType qf resize 3
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VISUAL SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set ruler colors
highlight ColorColumn ctermbg=254
" show line numbers
set number
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
set showbreak=»»
set textwidth=0
set wrapmargin=0
" visualize whitespace chars
set list listchars=tab:»\ ,trail:·

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
nnoremap j jzz
nnoremap k kzz
vnoremap j jzz
vnoremap k kzz
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
" key mapping to open vimrc
nnoremap <f10> :edit ~/.vimrc<cr>
" key mapping to write current file with sudo
cmap w!! w !sudo tee > /dev/null %
" key mapping to close the current buffer
nnoremap <leader>x :bd<cr>
" key mapping to edit a file
nnoremap <leader>e :e ./
" key mapping to paste with indentation based on the current context
nnoremap p p`[v`]=
" key mapping to exit terminal mode
tnoremap <esc> <c-\><c-n>
" key mappings to navigate between splits in temrinal mode
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
" key mappings to navigate between splits in normal mode
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" key mapping to open a terminal in below split
nnoremap <leader>t :below 10sp term://$SHELL<cr>
" disable noisy keys
nnoremap J <nop>
nnoremap K <nop>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')
" plugin provides sublime-liked multiple cursors
Plug 'terryma/vim-multiple-cursors'
" plugin previews hex/rgb/rgba colors
Plug 'lilydjwg/colorizer'
" plugin provides javascript syntax highlight
Plug 'pangloss/vim-javascript'
" plugin allows to comment out text depends on its syntax
Plug 'tpope/vim-commentary'
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
" plugin provides jsx syntax highlight
Plug 'mxw/vim-jsx'
let g:jsx_ext_required = 0
" plugin allows to search/replace with preview and undoable
Plug 'brooth/far.vim'
let g:far#window_layout = "current"
let g:far#auto_preview = 0
nnoremap <leader>f :F
nnoremap <leader>ff :Far
" plugin provides powerline-liked status line and tab line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme = 'base16_grayscale'
let g:airline_powerline_fonts = 1
let g:airline_left_sep = '▓▒░'
let g:airline_left_alt_sep = ' '
let g:airline_right_sep = '░▒▓'
let g:airline_right_alt_sep = ' '
let g:airline_section_warning= ''
" Show just the line and column number in section z
let g:airline_section_z = '%l:%v'
" enabled showing buffers on tabline
let g:airline#extensions#tabline#enabled = 1
" set filename mode to relative without being collapsed
let g:airline#extensions#tabline#fnamemod = ':.'
let g:airline#extensions#tabline#fnamecollapse = 0
" plugin provides asynchronous code completion
Plug 'maralla/completor.vim'
let g:completor_css_omni_trigger = '([\w-]+|@[\w-]*|[\w-]+:\s*[\w-]*)$'
" key mappings allow to use <tab> to select completion
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"
" plugin provides interactive window mode
Plug 'romgrk/winteract.vim'
nnoremap <leader>w :InteractiveWindow<cr>
" plugin provides text alignment feature
Plug 'junegunn/vim-easy-align'
vnoremap <leader>v :EasyAlign<cr>
" Plugin provides paramount color scheme
Plug 'pbrisbin/vim-colors-off'
set rtp+=~/.vim/plugged/vim-colors-off
set background=dark
colorscheme off
" plugin provides swift syntax highlight
Plug 'keith/swift.vim'
" plugin provides commands to convert between cases
Plug 'chiedo/vim-case-convert'
" plugin provides seamlessly key mappings working with tmux
Plug 'christoomey/vim-tmux-navigator'
" plugin provides async formatting
Plug 'sbdchd/neoformat'
augroup neoformat
  autocmd!
  autocmd FileType javascript.jsx setlocal formatprg=prettier_dnc\ --pkg-conf
  autocmd FileType javascript setlocal formatprg=prettier_dnc\ --pkg-conf
  autocmd BufWritePre *.js Neoformat
augroup END
" use formatprg when available
let g:neoformat_try_formatprg = 1
" https://github.com/sbdchd/neoformat/issues/25
let g:neoformat_only_msg_on_error = 1
" plugin provides async linting
Plug 'w0rp/ale'
let g:ale_linters = {'javascript': ['eslint']}
let g:ale_javascript_eslint_use_global = 1
let g:ale_set_quickfix = 1
let g:ale_open_list = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 0
let g:airline_section_error = '%{ale#statusline#Status()}'
let g:ale_warn_about_trailing_whitespace = 0
call plug#end()

