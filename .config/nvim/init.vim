" vim:fileencoding=utf-8:foldmethod=marker:foldmarker={{{,}}}

" General {{{

set nobackup
set nowritebackup
set noswapfile
set undofile
set undolevels=100
set undoreload=100
set splitbelow
set splitright
set confirm " ask to confirm closing an unsaved file
set hidden " switch between buffers without saving
set completeopt=menuone,preview
set encoding=utf-8
set clipboard^=unnamedplus,unnamed
set autoread " autoreload files on change
set backspace=indent,eol,start " make backspace work like most other apps
set incsearch " highlight search matching interactively
set hlsearch
set smartcase
set ignorecase
set inccommand=nosplit " show preview when replacing with :s
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set wildmenu " show auto-complete when typing in command line
set wildmode=longest,list
set wildignore+=.hg,.git,.svn
set nowrap
set showbreak=↪\ 
set foldenable
set foldmethod=syntax
set foldmarker={,}
set foldnestmax=5
set foldlevel=0
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
set fillchars+=fold:\ 
set foldtext=FormatFoldedText()
let g:loaded_netrwPlugin = 1
let g:loaded_matchparen = 1
let g:matchparen_timeout = 5 " timeout to abort searching
let g:matchparen_insert_timeout = 5
set laststatus=2
set statusline=%F
set noshowcmd
set noshowmode
set noruler
set lazyredraw

set termguicolors
set background=dark
colorscheme solarized

" use ripgrep as grepprg if available
if executable('rg')
  set grepprg=rg\ --vimgrep
endif

" Set %% to the dir that contains the current file
" http://vim.wikia.com/wiki/Easy_edit_of_files_in_the_same_directory
cabbr <expr> %% expand('%:p:h')

function! FormatFoldedText()
  let l:start = substitute(getline(v:foldstart), '^\s*', '', '')
  let l:end = getline(v:foldend)
  let l:indent = repeat(' ', indent(v:foldstart))

  if &foldmethod == "marker"
    let l:start = substitute(l:start, '{.*$', '{', '')
    let l:end = substitute(l:end, '^.*}', '}', '')
    return l:indent . l:start . '▾' . l:end
  endif

  return l:indent . l:start . ' ▾'
endfunction

augroup OptimizeIfLargeFile
  au!
  au BufReadPre * call OptimizeIfLargeFile("<afile>")
augroup END

" ref: http://vim.wikia.com/wiki/Faster_loading_of_large_files
let g:LargeFile = 1024 * 512 " 512KB
function! OptimizeIfLargeFile(file)
  let f=getfsize(expand(a:file))
  if f > g:LargeFile || f == -2
    " no syntax highlighting etc
    set eventignore+=FileType
    " save memory when other file is viewed
    " setlocal bufhidden=unload
    " is read-only (write with :w new_filename)
    " setlocal buftype=nowrite
    " no undo possible
    " setlocal undolevels=-1
  else
    set eventignore-=FileType
  endif
endfunction

" auto open qf after running :make, ...
" ref: http://vim.wikia.com/wiki/Automatically_open_the_quickfix_window_on_:make
augroup QF
  au!
  au QuickFixCmdPost [^l]* nested copen
  au QuickFixCmdPost l*    nested lopen
augroup END

augroup SourceVimrc
  au!
  au BufWritePost init.vim source %
augroup END

"}}}

" Keys {{{

let g:mapleader = ";"
let g:maplocalleader = "\\"

" write current file with sudo
cmap w! w !sudo tee > /dev/null %

nnoremap <leader>; :
nnoremap <leader>e :e 
nnoremap <leader>f :grep 
" clear searching
nnoremap ; :noh<CR>:<backspace>
" close current buffer except last one
nnoremap <leader>q :bp\|bd #<CR>

nnoremap <f2> :e ~/.config/nvim/init.vim<CR>
" reload current file and redraw
nnoremap <f5> :edit<cr>:redraw<cr>
" <f1> won't open vim help
nnoremap <f1> <esc>
inoremap <f1> <esc>
vnoremap <f1> <esc>
" <ecs> to escape temrinal mode
tnoremap <esc> <C-\><C-n>

" no more Ex mode
nnoremap Q <nop>
" jump to begin/end of a line
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L $
nnoremap B ^
nnoremap E $
vnoremap B ^
vnoremap E $
" unfold and fold others
nnoremap <space> zxzMzvzz
" vertical center movement
nnoremap G Gzz
vnoremap G Gzz
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap j jzz
nnoremap k kzz
vnoremap j jzz
vnoremap k kzz
" add new line below
nnoremap o o<esc>
" add new line above
nnoremap O O<esc>
" break lines
nnoremap J i<enter><esc>
" join lines
nnoremap K J
" last buffer
nnoremap gn <C-^>
" next buffer
nnoremap gt :bnext<cr>
" prev uffer
nnoremap gT :bprev<cr>
" redo
nnoremap U <c-r>zz
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
" move left/right one indent
nnoremap > >>
nnoremap < <<
vnoremap < <gv
vnoremap > >gv

nnoremap <leader>b :make<cr><cr>

" Search selecting
" Ref: http://vim.wikia.com/wiki/Search_for_visually_selected_text<Paste>
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" }}}

" Plugins {{{

call plug#begin('~/.config/nvim/plugged')

" improved javascript syntax
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }

" jsx syntax
Plug 'MaxMEllon/vim-jsx-pretty', { 'for': 'javascript' } " {{{

hi! link jsxCloseTag jsxTag
hi! link jsxCloseString jsxTag

" }}}

" commenting
Plug 'tpope/vim-commentary'

" fuzzy searching
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim' " {{{

" quick open files by name with fuzzy autocompletion
nnoremap <leader>p :FZF<cr>
" fuzzy search text in the current buffer
nnoremap <leader>r :BLines<cr>

augroup FZF
  au!
  " <ecs> doesn't close fzf window because it's in terminal mode,
  " this trick remaps <ecs> in terminal mode to behave normally
  au TermOpen term://*FZF tnoremap <silent> <buffer><nowait> <esc> <c-c>
augroup end

"}}}

" wb word by word
Plug 'chaoren/vim-wordmotion' 

" automatically add end tag
Plug 'alvan/vim-closetag' "{{{

let g:closetag_filenames = "*.html,*.xml,*.js,*.jsx"

" }}}

" provides a buffer line which looks like the tab line
Plug 'ap/vim-buftabline' "{{{

let g:buftabline_indicators = 1
let g:buftabline_plug_map = 0

hi! link BufTabLineCurrent   TablineSel
hi! link BufTabLineActive    TablineSel
hi! link BufTabLineHidden    Tabline
hi! link BufTabLineFill      TablineFill

" }}}

" toolkit for develop golang
Plug 'fatih/vim-go', { 'for': 'go' }

" likes ! but output into a buffer
Plug 'sjl/clam.vim' "{{{

nnoremap !! :!<space>
nnoremap ! :Clam<space>
vnoremap ! :ClamVisual<space>

" }}}

" allow to edit and save changes in quickfix
Plug 'stefandtw/quickfix-reflector.vim'

Plug 'terryma/vim-multiple-cursors' "{{{

hi link multiple_cursors_cursor Cursor
hi link multiple_cursors_visual Search

" }}}

" provides :Rename command
Plug 'danro/rename.vim'

Plug 'dhruvasagar/vim-table-mode'

Plug 'airblade/vim-gitgutter' "{{{

set updatetime=2000

let g:gitgutter_enabled = 0
let g:gitgutter_signs = 1
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_diff_args = '-w'
let g:gitgutter_map_keys = 0
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '≠'
let g:gitgutter_sign_removed = '_'
let g:gitgutter_sign_modified_removed = '≠'

hi link GitGutterAdd DiffAdd
hi link GitGutterChange DiffChange
hi link GitGutterChangeDelete DiffChange
hi link GitGutterDelete DiffDelete

nmap <leader>d :call gitgutter#toggle()<cr>
nmap <silent> ]d :call gitgutter#hunk#next_hunk(1)<cr>zz
nmap <silent> [d :call gitgutter#hunk#prev_hunk(1)<cr>zz

" }}}

Plug 'junegunn/vim-easy-align' "{{{

xmap ga <Plug>(EasyAlign)

" }}}

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } "{{{

let g:deoplete#enable_at_startup = 1
let g:deoplete#file#enable_buffer_path = 1

" select completion items by <tab>-ing
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ deoplete#mappings#manual_complete()

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" }}}

Plug 'thenewvu/vim-plantuml-genin'

" async linting
Plug 'w0rp/ale' "{{{

let g:ale_fix_on_save = 1
let g:ale_open_list = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_filetype_changed = 0
let g:ale_warn_about_trailing_whitespace = 0

let g:ale_set_highlights = 0
let g:ale_set_signs = 1
let g:ale_sign_error = '⚑'
let g:ale_sign_warning = '⚑'

let g:ale_linters = {}
let g:ale_fixers = {}
let g:ale_linters['c'] = ['clang']
let g:ale_c_parse_makefile = 1

nmap <leader>l :ALEToggle<cr>
nmap <silent> [l :call ale#loclist_jumping#Jump('before', 1)<cr>zz
nmap <silent> ]l :call ale#loclist_jumping#Jump('after', 1)<cr>zz

hi link ALEError       ErrorMsg
hi link ALEErrorSign   ErrorMsg
hi link ALEWarning     WarningMsg
hi link ALEWarningSign WarningMsg

" }}}

Plug 'Yggdroot/indentLine' "{{{

  let g:indentLine_enabled = 1
  let g:indentLine_color_gui = '#504945'
  let g:indentLine_bgcolor_gui = 'none'
  let g:indentLine_char = '⋮'

"}}}

call plug#end()

" }}}
