""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BEHAVIOR SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set leader to >;<
let g:mapleader = ";"
" disable backup and swap files
set nobackup
set noswapfile
" enable syntax processing
syntax enable
" display a confirm dialog when closing an unsaved file
set confirm
" set default encoding to utf-8
set encoding=utf-8
" use the system clipboard when yank something
set clipboard^=unnamedplus,unnamed
" open files from buffers into a new tab or existing
" tab that opening the file
set switchbuf+=usetab,newtab
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
" enable folding for vim syntax
let vim_fold=1
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

" auto source .vimrc on save
augroup auto_source_vimrc
  autocmd!
  autocmd BufWritePost .vimrc source %
augroup END

" auto source .Xresources on save
augroup auto_source_xresources
  autocmd!
  autocmd BufWritePost .Xresources AsyncRun xrdb "%:p"
augroup END

" auto trim trailing whitespaces on save
augroup trim_trailing_whitespaces
  autocmd BufWritePre *.js,*.css,*.html %s/\s\+$//e
augroup END

" auto format javascript files on save
augroup auto_format_js
 autocmd!
 autocmd BufWritePost *.js AsyncRun standard --fix %
augroup END

" auto format css files on save
augroup auto_format_css
 autocmd!
 autocmd BufWritePost *.css AsyncRun csscomb -c ~/.csscomb.json %
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VISUAL SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set color scheme
colorscheme mac_classic
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
set list listchars=trail:·,tab:»\ 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" KEY SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" key mapping to toggle paste mode
set pastetoggle=<F2>
" key mappings to jump to begin/end of lines
nnoremap B ^
nnoremap E $
" key mapping to scroll buffers
nnoremap <C-j> <esc><C-e>
nnoremap <C-k> <esc><C-y>
inoremap <C-j> <esc><C-e>
inoremap <C-k> <esc><C-y>
vnoremap <C-j> <esc><C-e>
vnoremap <C-k> <esc><C-y>
" key mapping to unfold current block and close other blocks
nnoremap <space> zMzvzz
" key mapping to clear highlighing search marches
nnoremap <leader><space> :nohlsearch<CR>
" key mapping to close current buffer
nnoremap <C-w> :bdelete<CR>
" key mapping to open a new file in a new tab or
" the existing tab that opening the file
nnoremap <C-t> :tab drop ./
" key mapping to save the current file as sudo
cmap w!! w !sudo tee > /dev/null %
" key mappings to navigate between windows
nnoremap <A-j> <C-W><C-J>
nnoremap <A-k> <C-W><C-K>
nnoremap <A-l> <C-W><C-L>
nnoremap <A-h> <C-W><C-H>
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
nnoremap <f10> :tab drop ~/.vimrc<cr>
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
" centerize highlighted search
nnoremap n nzz
nnoremap N Nzz
" key mapping to exit terminal mode
tnoremap <Esc> <C-\><C-n>
" key mapping to navigate to split windows when terminal mode
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
tnoremap <A-H> <C-\><C-n>gT
tnoremap <A-L> <C-\><C-n>gt

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')
Plug 'terryma/vim-multiple-cursors'
Plug 'lilydjwg/colorizer'
Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
nnoremap <C-p> :FZF<CR>
nnoremap <c-r> :BLines<cr>
Plug 'chaoren/vim-wordmotion'
Plug 'tpope/vim-fugitive'
Plug 'sickill/vim-pasta'
Plug 'othree/html5.vim'
Plug 'alvan/vim-closetag'
let g:closetag_filenames = "*.html,*.xml,*.js,*.jsx"
Plug 'mxw/vim-jsx'
let g:jsx_ext_required = 0
Plug 'brooth/far.vim'
let g:far#window_layout = "tab"
let g:far#auto_preview = 0
let g:far#source = 'vimgrep'
nnoremap <leader>f :F 
nnoremap <leader>F :Far
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme= 'base16'
let g:airline_powerline_fonts = 2
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':.'
let g:airline#extensions#tabline#fnamecollapse = 0
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1
" autocomplete filepaths based on current path of current file
let g:deoplete#file#enable_buffer_path = 1
Plug 'ervandew/supertab'
Plug 'skywind3000/asyncrun.vim'
noremap <F3> :call asyncrun#quickfix_toggle(8)<cr>
let g:airline_section_error = '%{g:asyncrun_status}'
call plug#end()

