""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STARTUP SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" recognize *.md as markdown files
autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BEHAVIOR SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" enable syntax processing
syntax enable

" make backspace work like most other apps
set backspace=indent,eol,start

" fix delete key doesn't work as expected
:fixdel

" disable swap file
set noswapfile

" set maximum of tabs
set tabpagemax=5

" enable mouse interactive
set mouse=a

" search ignore case by default
set ignorecase

" redraw only when we need to.
set lazyredraw

" search as characters are entered
set incsearch

" enable folding
set foldenable
" set fold method to `syntax`
set foldmethod=syntax
" only fold the first level
set foldnestmax=100 foldlevel=0
" auto fold for javascript
let javaScript_fold=1

" use ripgrep to search if available
if executable('rg')
  set grepprg=rg\ --no-heading\ --vimgrep
  set grepformat=%f:%l:%c:%m
endif

" syntastic settings
set statusline=%f
set statusline+=%=\ 
set statusline+=%{SyntasticStatuslineFlag()}[%l,%v][%p%%]
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exe = 'eslint -c ~/.eslint/config.yaml'

let g:syntastic_error_symbol = ''
let g:syntastic_style_error_symbol = ''
let g:syntastic_warning_symbol = ''
let g:syntastic_style_warning_symbol = ''

highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn

" fzf settings
" jump to the existing window/tab if possible
let g:fzf_buffers_jump = 1
let g:fzf_action = {
  \ 'ctrl-t': 'tab drop',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VISUAL SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" highlight the column at the cursor
" set cursorcolumn

" highlight the 100th column as a ruler
" set colorcolumn=100
" hi ColorColumn ctermbg=grey

" style SignColumn
hi SignColumn ctermbg=yellow ctermfg=white

" number of visual spaces per TAB
set tabstop=2
" number of spaces in tab when editing
set softtabstop=2
" set indent size
set shiftwidth=2
" tabs are spaces
set expandtab

" show line numbers
" set number

" show command in bottom bar
set showcmd

" show status bar by default
set laststatus=2

" visual autocomplete for command menu
set wildmenu

" highlight matching [{()}]
set showmatch

" highlight search matches
set hlsearch

" wrap text at the 100th column
set textwidth=100 wrapmargin=0

" decorate folds
hi Folded ctermbg=white cterm=standout

" display whitespace chars
set list listchars=trail:·,tab:»\ 
" decorate whitespaces
highlight SpecialKey ctermfg=7 guifg=gray

" decorate foldtext
" ref: http://www.gregsexton.org/2011/03/improving-the-text-displayed-in-a-fold/
fu! CustomFoldText()
  "get first non-blank line
  let fs = v:foldstart
  while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
  endwhile
  if fs > v:foldend
    let line = getline(v:foldstart)
  else
    let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
  endif

  let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
  let foldSize = 1 + v:foldend - v:foldstart
  let foldSizeStr = " " . foldSize . " lines "
  let lineCount = line("$")
  let foldPercentage = printf("[%4.1f", (foldSize*1.0)/lineCount*100) . "%] "
  let expansionString = repeat(".", w - strwidth(foldSizeStr.line.foldPercentage))
  return line . expansionString . foldSizeStr . foldPercentage
endf
" custom fold text function (cleaner than default)
set foldtext=CustomFoldText()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.vim/plugged')

Plug 'terryma/vim-multiple-cursors'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/vim-easy-align'
Plug 'lilydjwg/colorizer'
Plug 'pangloss/vim-javascript'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'romgrk/winteract.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'bkad/CamelCaseMotion'

" Add plugins to &runtimepath
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" KEY SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" move to beginning/end of line
nnoremap B ^
nnoremap E $
" $/^ doesn't do anything
nnoremap $ <nop>
nnoremap ^ <nop>

" space to open/closes folds
nnoremap <space> zMzv

" <leader><space> to turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

" <ctrl><w> to close the current tab
nnoremap <C-w> :q<CR>

" <ctrl><t> to open some file in a new tab
nnoremap <C-t> :tab drop 

" <ctrl><f> to search some text
nnoremap <C-f> :grep -F 

" allow saving of files as sudo
cmap w!! w !sudo tee > /dev/null %

" <ctrl><b> to toggle NERDTree
nnoremap <C-b> :NERDTreeToggle<CR>

" <ctrl><p> to fzf
nnoremap <C-p> :FZF<CR>

" <ctrl><jklh> to navigate to splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Start interactive window
nmap gw :InteractiveWindow<CR>

" Overwrite, w,b,e,ge by CamelCaseMotion
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
map <silent> ge <Plug>CamelCaseMotion_ge

