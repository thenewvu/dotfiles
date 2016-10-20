""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UTILS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" function that adjusts window height
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction

" function that toggles vietnamese telex keymap
let g:keymap_vi = 0
function! ToggleKeymapVietnamese()
    if g:keymap_vi
        let g:keymap_vi = 0
        execute "set keymap="
    else
        execute "set keymap=vietnamese-telex"
        let g:keymap_vi = 1
    endif
endfunction

" function that returns a cleaner fold text title
" ref: http://www.gregsexton.org/2011/03/improving-the-text-displayed-in-a-fold/
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BEHAVIOR SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" auto source .vimrc on change
augroup auto_source_vimrc
  autocmd!
  autocmd BufWritePost .vimrc source %
augroup END

" auto open *.md as markdown
augroup open_md_as_markdown
  autocmd!
  autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
augroup END

" adjust quick fix window height
au FileType qf call AdjustWindowHeight(1, 3)

" enable syntax processing
syntax enable

" display a confirm dialog when closing an unsaved file
set confirm

" set default encoding
set encoding=utf-8

" use the system clipboard
set clipboard^=unnamedplus,unnamed

" open file in new tabs from quick list
set switchbuf+=usetab,newtab

" enable auto-indenting when pasting by default
" set paste

" autoreload when files are changed outside of vim
set autoread

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

" search with smart case
set smartcase

" optimize rendering
set lazyredraw
set ttyfast

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

" use ripgrep to search text if available
if executable('rg')
  set grepprg=rg\ --no-heading\ --vimgrep
  set grepformat=%f:%l:%c:%m
endif

" syntastic settings
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_loc_list_height = 2
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_full_redraws=1
let g:syntastic_javascript_checkers = ['standard']

" format js files on save in suckless way
" ref: http://learnvimscriptthehardway.stevelosh.com/chapters/14.html
:augroup auto_format_js
: autocmd!
: autocmd BufWritePost *.js silent !standard --fix %
: autocmd BufWritePost *.js redraw!
:augroup END

" fzf settings
" jump to the existing window/tab if possible
let g:fzf_buffers_jump = 1
let g:fzf_action = {
  \ 'ctrl-t': 'tab drop',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" vimfiler settings
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default = 0
let g:vimfiler_enable_auto_cd = 1

" vim-markdown settings
let g:vim_markdown_folding_disabled = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VISUAL SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" custom selection color
hi Visual ctermbg=7 ctermfg=None

" custom SignColumn color
hi SignColumn ctermbg=White ctermfg=Yellow

" custom syntastic error color
hi SpellBad ctermfg=Yellow ctermbg=White
hi SpellCap ctermfg=Yellow ctermbg=White

" custom search color
hi Search ctermfg=15 ctermbg=3

" custom tab bar color
hi TabLineFill ctermfg=LightGrey ctermbg=Black cterm=none
hi TabLine ctermfg=LightGrey ctermbg=Black cterm=none
hi TabLineSel ctermfg=Black ctermbg=White cterm=none
hi Title ctermfg=LightGrey ctermbg=Black cterm=none

" custom status line color
hi StatusLine ctermfg=White ctermbg=Black cterm=none
hi StatusLineNC ctermfg=White ctermbg=Black cterm=none

" custom matched bracket color
hi MatchParen cterm=none ctermbg=Yellow ctermfg=White

" custom fold title color
hi Folded ctermbg=White cterm=standout

" custom syntastic error symbol on SignColumn
let g:syntastic_error_symbol = '>>'
let g:syntastic_style_error_symbol = 'S>'
let g:syntastic_warning_symbol = '>>'
let g:syntastic_style_warning_symbol = 'S>'

" show all syntastic errors on SignColumn
hi link SyntasticErrorSign SignColumn
hi link SyntasticWarningSign SignColumn
hi link SyntasticStyleErrorSign SignColumn
hi link SyntasticStyleWarningSign SignColumn

" display whitespace chars
set list listchars=trail:·,tab:»\ 
" custom whitespace color
hi SpecialKey ctermfg=LightGrey

" show relative line numbers
set relativenumber
" custom line number color
hi LineNr ctermfg=LightGrey ctermbg=White
hi CursorLineNr ctermfg=LightGrey ctermbg=White

" custom statusline
set statusline=%f
set statusline+=%=\ 
set statusline+=%{SyntasticStatuslineFlag()}[%l,%v][%p%%]
set statusline+=%*

" number of visual spaces per TAB
set tabstop=2
" number of spaces in tab when editing
set softtabstop=2
" set indent size
set shiftwidth=2
" tabs are spaces
set expandtab

" show command in bottom bar
set showcmd

" show status bar by default
set laststatus=2

" visual autocomplete for command menu
set wildmenu

" color matching [{()}]
set showmatch

" color search matches
set hlsearch

" wrap text at the 100th column
set wrap
set linebreak
set textwidth=100 wrapmargin=0

" set custom create fold text function
set foldtext=GenFoldText()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.vim/plugged')

Plug 'terryma/vim-multiple-cursors'
Plug 'junegunn/vim-easy-align'
Plug 'lilydjwg/colorizer'
Plug 'pangloss/vim-javascript'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'romgrk/winteract.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-grepper'
Plug 'chaoren/vim-wordmotion'
Plug 'Shougo/unite.vim'
Plug 'haya14busa/vimfiler.vim'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" Add plugins to &runtimepath
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" KEY SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" <f2> to toggle paste mode
set pastetoggle=<F2>

" move vertically by visual line
nmap j gj<space>
nmap k gk<space>

" move to beginning/end of line
nnoremap B ^
nnoremap E $

" $/^ doesn't do anything
" nnoremap $ <nop>
" nnoremap ^ <nop>

" <ctr><q> works as <ctrl><y> to scroll buffer up
nnoremap <C-j> <C-e>
nnoremap <C-k> <C-y>

" space to open/closes folds
nnoremap <space> zMzv

" <leader><space> to turn off search color
nnoremap <leader><space> :nohlsearch<CR>

" <ctrl><w> to close the current tab
nnoremap <C-w> :tabclose<CR>

" <ctrl><t> to open some file in a new tab
nnoremap <C-t> :tab drop 

" allow saving of files as sudo
cmap w!! w !sudo tee > /dev/null %

" <ctrl><b> to toggle file explorer 
nnoremap <C-b> :VimFilerExplorer<CR>

" <ctrl><p> to fzf
nnoremap <C-p> :FZF<CR>

" <ctrl><jklh> to navigate to splits
execute "set <M-J>=\ej"
nnoremap <M-J> <C-W><C-J>
execute "set <M-K>=\ek"
nnoremap <M-K> <C-W><C-K>
execute "set <M-L>=\el"
nnoremap <M-L> <C-W><C-L>
execute "set <M-H>=\eh"
nnoremap <M-H> <C-W><C-H>

" mappings to move lines
" ref: http://vim.wikia.com/wiki/Moving_lines_up_or_down
nnoremap <S-j> :m .+1<CR>==
nnoremap <S-k> :m .-2<CR>==
vnoremap <S-j> :m '>+1<CR>gv=gv
vnoremap <S-k> :m '<-2<CR>gv=gv

" remap <o> to avoid hanging
nnoremap <o> <S-A><CR><i>

" <ctrl><s> to save file
nnoremap <C-S> :w<CR>
inoremap <C-S> <esc>:w<CR>

" <ctrl><a> to select all
nnoremap <C-A> gg<S-V><S-G>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Start interactive window
nmap gw :InteractiveWindow<CR>

" <ctrl><f> to :Grepper
nnoremap <C-f> :Grepper<cr>

" <ctrl><r> to search in the current file
nnoremap <c-r> /

" <ctrl><v> to paste in normal and insert mode
nnoremap <c-v> <f2>p<f2>
inoremap <c-v> <esc><f2>p<f2>i

" <ctrl><shift><u> to redo
nnoremap <c-s-u> <c-r>

" <F5> to redraw
nnoremap <F5> :redraw!<cr>

" <alt><z> to toggle vietnamese-telex keymap
execute "set <m-z>=\ez"
nnoremap <m-z> :call ToggleKeymapVietnamese()<cr>
inoremap <m-z> <esc>:call ToggleKeymapVietnamese()<cr>i

