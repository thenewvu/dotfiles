""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BEHAVIOR SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set leader to >;<
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
set mouse=a
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
augroup auto_source
  autocmd!
  autocmd BufWritePost .vimrc source % | AirlineRefresh
  autocmd BufWritePost bspwmrc !%
  autocmd BufWritePost sxhkdrc !pkill -USR1 -x sxhkd
  autocmd BufWritePost .Xresources AsyncRun xrdb "%:p"
  autocmd BufWritePost config.fish !. %
  autocmd BufWritePre *.js,*.css,*.html %s/\s\+$//e
  autocmd BufWritePost *.js AsyncRun
    \ -post=:call\ ReloadFileAfterFormatted()
    \ standard --fix %
  autocmd BufWritePost *.css AsyncRun
    \ -post=:call\ ReloadFileAfterFormatted()\ |\ silent!\ g/^$/d\ |\ noautocmd\ w
    \ csscomb %
  autocmd TermOpen * setlocal bufhidden=hide
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VISUAL SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set ruler
set colorcolumn=80
" set preferred text width
set textwidth=80
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
" key mapping to unfold current block and close other blocks
nnoremap <space> zMzv
" key mapping to clear highlighing search marches
nnoremap <leader><space> :nohlsearch<CR>
" key mapping to close current buffer
nnoremap <C-w> :bdelete<CR>
" key mapping to open a new file
nnoremap <C-t> :edit ./
" key mapping to save the current file as sudo
cmap w!! w !sudo tee > /dev/null %
" key mappings to navigate between windows
nnoremap <A-j> <C-W><C-J>
nnoremap <A-k> <C-W><C-K>
nnoremap <A-l> <C-W><C-L>
nnoremap <A-h> <C-W><C-H>
tnoremap <A-j> <C-\><C-n><C-W><C-J>
tnoremap <A-k> <C-\><C-n><C-W><C-K>
tnoremap <A-l> <C-\><C-n><C-W><C-L>
tnoremap <A-h> <C-\><C-n><C-W><C-H>
" key mappings to save current file
nnoremap <C-S> <esc>:w<CR>
inoremap <C-S> <esc>:w<CR>
" key mapping to select all
nnoremap <C-A> gg<S-V><S-G>
" key mapping to paste with paste mode
nnoremap <C-v> <f2>p<f2>
inoremap <C-v> <esc><f2>p<f2>i
" key mapping to redo
nnoremap <c-s-u> <c-r>
" key mapping to toggle Vietnamese telex input
nnoremap <m-z> :call ToggleKeymapVietnamese()<cr>
inoremap <m-z> <esc>:call ToggleKeymapVietnamese()<cr>i
" key mapping to reload current file then force to redraw
nnoremap <c-l> :edit<cr>:redraw<cr>
" key mapping to open vimrc
nnoremap <f10> :edit ~/.vimrc<cr>
" key mapping to insert new line without entering insert mode
nnoremap o o<esc>
nnoremap O O<esc>
" disable mapping on <f1>
nnoremap <f1> <nop>
inoremap <f1> <nop>
vnoremap <f1> <nop>
" key mapping to underline markdown headers
" ref: https://goo.gl/6zf93B
nnoremap <leader>mh yypVr-
nnoremap <leader>mH yypVr=
" key mapping to create a new directory
nnoremap <c-d> :!mkdir ./
" key mapping to move current line up/down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
" overwrite key mappings to centerize highlighted search
nnoremap n nzz
nnoremap N Nzz
" overwrite key mappings to navigate buffers
nnoremap gt :bn<cr>
nnoremap gT :bp<cr>
" overwrite key mappings to make the caret always be middle
nnoremap j jzz
nnoremap k kzz
vnoremap j jzz
vnoremap k kzz
" key mapping to open terminal
nnoremap <leader>t :8split term://fish<cr>

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
nnoremap <C-p> :FZF<CR>
" key mapping to fuzzy search text in the current buffer
nnoremap <c-r> :BLines<cr>
" plugin allows to <w>/<b> over words
Plug 'chaoren/vim-wordmotion'
" plugin provides git functions, only required by airline so far
Plug 'tpope/vim-fugitive'
" plugin allows to paste with indentation adjusted based on the current context
Plug 'sickill/vim-pasta'
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
nnoremap <leader>r :Far
" plugin provides powerline-liked status line and tab line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme= 'aurora'
let g:airline_powerline_fonts = 2
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
" plugin provides a way to run asynchronously shell commands
Plug 'skywind3000/asyncrun.vim'
" key mapping toggle quickfix with a given height
noremap <F3> :call asyncrun#quickfix_toggle(8)<cr>
" show asyncrun's status on airline's error section
let g:airline_section_error = '%{g:asyncrun_status}'
" plugin provides interactive window mode
Plug 'romgrk/winteract.vim'
nnoremap <leader>w :InteractiveWindow<cr>
tnoremap <leader>w <C-\><C-n>:InteractiveWindow<cr>
" plugin provides text alignment feature
Plug 'junegunn/vim-easy-align'
vnoremap <leader>a :EasyAlign<cr>
" plugin provides faster horizontal movement
Plug 'rhysd/clever-f.vim'
let g:clever_f_ignore_case = 1
let g:clever_f_fix_key_direction = 1
let g:clever_f_across_no_line = 1
let g:clever_f_chars_match_any_signs = ';'
" plugin provdes hemisu color scheme
Plug 'noahfrederick/vim-hemisu'
set rtp+=~/.vim/plugged/vim-hemisu
set background=light
colorschem hemisu
call plug#end()

