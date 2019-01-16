" vim:fileencoding=utf-8:foldmethod=marker:foldmarker={{{,}}}

" General {{{

set nobackup nowritebackup noswapfile
set undofile undolevels=500 undoreload=500
set splitright
set confirm " ask to confirm closing an unsaved file
set hidden " switch between buffers without saving
set completeopt=menu,menuone,noselect,noinsert
set encoding=utf-8
set clipboard^=unnamedplus,unnamed
set autoread " autoreload files on change
set backspace=indent,eol,start " make backspace work like most other apps
set incsearch hlsearch smartcase ignorecase inccommand=nosplit gdefault
set expandtab smarttab tabstop=4 shiftwidth=4 softtabstop=4 
set wildmenu " show auto-complete when typing in command line
set wildmode=longest,list
set wildignore+=.hg,.git,.svn
set nowrap breakindent linebreak breakindentopt=shift:2 breakat='\ ^I;,'
set showbreak=↪\ 
set foldenable foldmethod=syntax foldmarker={,} foldnestmax=5 foldlevel=0
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
set fillchars+=fold:\ 
set foldtext=FoldText()
let g:loaded_netrwPlugin = 1
let g:loaded_matchparen = 1
let g:matchparen_timeout = 5 " timeout to abort searching
let g:matchparen_insert_timeout = 5
let g:c_syntax_for_h = 1
set laststatus=2
set statusline=%F
set noshowcmd
set noshowmode
set noruler
set nonumber
set signcolumn=yes
set autoindent smartindent
set lazyredraw
set synmaxcol=320
set diffopt+=algorithm:histogram,iwhiteall,iblank,iwhiteeol
set nolist listchars=tab:\│\ ,trail:␣
set shortmess+=c

" Set %% to the dir that contains the current file
" http://vim.wikia.com/wiki/Easy_edit_of_files_in_the_same_directory
cabbr <expr> %% expand('%:p:h')

function! FoldText()
  let l:start = substitute(getline(v:foldstart), '^\s*', '', '')
  let l:end = getline(v:foldend)
  let l:indent = repeat(' ', indent(v:foldstart))

  if &syntax == "markdown"
    return l:indent . l:start
  endif

  if &foldmethod == "marker"
    let l:start = substitute(l:start, '{.*$', '{', '')
    let l:end = substitute(l:end, '^.*}', '}', '')

    if &syntax == "c" || &syntax == "cpp"
      if l:end =~ "}.*\\"
        let l:end = "}"
      endif
    endif

    return l:indent . l:start . '▾' . l:end
  endif

  return l:indent . l:start . ' ▾'
endfunction 

" ref: http://vim.wikia.com/wiki/Faster_loading_of_large_files
let g:LargeFileThreshold = 1024 * 512 " 512KB
function! SpeedRead(file)
  let f=getfsize(expand(a:file))
  if f > g:LargeFileThreshold || f == -2
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

augroup All
    au!

    " speed up editing large files
    au BufReadPre * call SpeedRead("<afile>")

    " auto resource $MYVIMRC on change
    au BufWritePost $MYVIMRC source %

    " better recognizing markdown files
    au BufRead,BufNewFile *.markdown set filetype=markdown
    au BufRead,BufNewFile *.md       set filetype=markdown
    au BufRead,BufNewFile *.MD       set filetype=markdown

    au TermOpen * setlocal signcolumn=no
augroup END

" }}}

" Keys {{{

let g:mapleader = ";"
let g:maplocalleader = "\\"

" write current file with sudo
cmap w! w !sudo tee > /dev/null %

nnoremap <leader>e :e 
" clear searching
nnoremap ; :noh<CR>:<backspace>
" close current tab
nnoremap <leader>q :bp<bar>sp<bar>bn<bar>bd<cr>
nnoremap H :bprev<cr>
nnoremap L :bnext<cr>

nnoremap <f2> :e ~/.config/nvim/init.vim<cr>
" reload current file and redraw
nnoremap <f5> :edit<cr>:redraw<cr>
" <ecs> to escape temrinal mode
tnoremap <esc> <C-\><C-n>

" no more Ex mode
nnoremap Q <nop>
" jump to begin/end of a line
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
nnoremap j gjzz
nnoremap k gkzz
vnoremap j gjzz
vnoremap k gkzz
" break lines
nnoremap J i<enter><esc>
" join lines
nnoremap K J
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

nnoremap ` <C-^>
nnoremap <tab> <C-o>

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
Plug 'MaxMEllon/vim-jsx-pretty', { 'for': 'javascript' } 
" {{{

    hi! link jsxCloseTag jsxTag
    hi! link jsxCloseString jsxTag

" }}}

" commenting
Plug 'tpope/vim-commentary'

" fuzzy searching
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim' 
" {{{

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

" }}}

Plug 'tpope/vim-fugitive'
Plug 'kablamo/vim-git-log', { 'on': 'GitLog' }
"{{{

    nnoremap <silent> <leader>gl :GitLog<cr>

"}}}

" wb word by word
Plug 'chaoren/vim-wordmotion' 

" automatically add end tag
Plug 'alvan/vim-closetag' 
" {{{

  let g:closetag_filenames = "*.html,*.xml,*.js,*.jsx"

" }}}

" auto add )}]'" after ({['"
Plug 'jiangmiao/auto-pairs'

" likes ! but output into a buffer
Plug 'sjl/clam.vim', { 'on': 'Clam' }
" {{{

  nnoremap !! :!<space>
  nnoremap ! :Clam<space>
  vnoremap ! :ClamVisual<space>

" }}}

Plug 'terryma/vim-multiple-cursors' 
" {{{

  hi link multiple_cursors_cursor Cursor
  hi link multiple_cursors_visual Search

" }}}

" provides :Rename command
Plug 'danro/rename.vim'

Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeEnable' }

Plug 'airblade/vim-gitgutter' 
" {{{

  set updatetime=1000

  let g:gitgutter_enabled = 1
  let g:gitgutter_signs = 1
  let g:gitgutter_override_sign_column_highlight = 0
  let g:gitgutter_diff_args = '-w'
  let g:gitgutter_sign_added = '\ '
  let g:gitgutter_sign_modified = '\ '
  let g:gitgutter_sign_removed = '\ '
  let g:gitgutter_sign_modified_removed = '\ '

  hi link GitGutterAdd DiffAdd
  hi link GitGutterChange DiffText
  hi link GitGutterChangeDelete DiffText
  hi link GitGutterDelete DiffDelete

  nmap <leader>gd :call gitgutter#toggle()<cr>

" }}}

Plug 'junegunn/vim-easy-align' 
" {{{

  xmap ga <Plug>(EasyAlign)

" }}}

" async linting
Plug 'w0rp/ale' 
" {{{

    let g:ale_fix_on_save = 1
    let g:ale_open_list = 1
    let g:ale_set_loclist = 1
    let g:ale_lint_on_save = 1
    let g:ale_lint_on_enter = 0
    let g:ale_lint_on_text_changed = 0
    let g:ale_lint_on_filetype_changed = 0
    let g:ale_warn_about_trailing_whitespace = 0
    let g:ale_completion_enabled = 0

    let g:ale_set_highlights = 1
    let g:ale_set_signs = 1
    let g:ale_sign_error = '\ '
    let g:ale_sign_warning = '\ '

    let g:ale_linters = {}
    let g:ale_linters['c'] = ['clangd']
    let g:ale_linters['cpp'] = ['clangd']
    let g:ale_linters['markdown'] = ['markdownlint']

    let g:ale_fixers = {}
    let g:ale_fixers['c'] = ['clang-format']
    let g:ale_c_clangformat_options = '-style=file -assume-filename=file.c'
    let g:ale_fixers['cpp'] = ['clang-format']
    let g:ale_cpp_clangformat_options = '-style=file -assume-filename=file.cpp'
    let g:ale_fixers['javascript'] = ['prettier']

    nmap <leader>l :ALEToggle<cr>
    nmap <silent> ]l :call ale#loclist_jumping#Jump('before', 1)<cr>zz
    nmap <silent> [l :call ale#loclist_jumping#Jump('after', 1)<cr>zz

    hi link ALEError       ErrorMsg
    hi link ALEErrorSign   ErrorMsg
    hi link ALEWarning     WarningMsg
    hi link ALEWarningSign WarningMsg

    function! LinterStatus() abort
        let l:counts = ale#statusline#Count(bufnr(''))

        let l:all_errors = l:counts.error + l:counts.style_error
        let l:all_non_errors = l:counts.total - l:all_errors

        return l:counts.total == 0 ? 'OK' : printf(
        \   '%dW %dE',
        \   all_non_errors,
        \   all_errors
        \)
    endfunction

    set statusline+=%=%{LinterStatus()}

" }}}

Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/asyncomplete-file.vim'
"{{{

    let g:lsp_diagnostics_enabled = 0
    let g:lsp_preview_keep_focus = 0

    hi link LspErrorText ErrorMsg
    hi link LspWarningLine WarningMsg

    nmap <leader>ld <plug>(lsp-definition)
    nmap <leader>li <plug>(lsp-hover)
    nmap <leader>lR <plug>(lsp-rename)
    nmap <leader>lf <plug>(lsp-code-action)
    nmap ]l <plug>(lsp-next-error)
    nmap [l <plug>(lsp-previous-error)

    augroup ASYNCOMPLETE
        au!
        au User lsp_setup call lsp#register_server({
            \ 'name': 'clangd',
            \ 'cmd': {server_info->['clangd']},
            \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
            \ })
        au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
            \ 'name': 'file',
            \ 'whitelist': ['*'],
            \ 'priority': 10,
            \ 'completor': function('asyncomplete#sources#file#completor')
            \ }))

        au FileType *.lsp-hover nnoremap <buffer><esc> :pclose<cr>
    augroup END

"}}}

Plug 'Yggdroot/indentLine' 
" {{{

  let g:indentLine_enabled = 1
  let g:indentLine_faster = 1
  let g:indentLine_bufTypeExclude = ['help', 'terminal']
  let g:indentLine_fileTypeExclude = ['markdown', 'git']
  let g:indentLine_char = '│'
  let g:indentLine_color_gui = '#2c4e6c'
  let g:indentLine_bgcolor_gui = 'none'

" }}}

Plug 'thenewvu/vim-colors-blueprint' 
" {{{

  set rtp+=~/.config/nvim/plugged/vim-colors-blueprint
  set termguicolors
  set background=dark
  colorscheme blueprint

" }}}

" Workaround for issue:
" https://github.com/neovim/neovim/issues/1822
Plug 'bfredl/nvim-miniyank' 
" {{{

    map p <Plug>(miniyank-autoput)
    map P <Plug>(miniyank-autoPut)

" }}}

Plug 'simnalamburt/vim-mundo', { 'on': 'MundoToggle' }
" {{{

  let g:mundo_width = 120
  let g:mundo_preview_height = 20
  
  nnoremap <leader>u :MundoToggle<cr>

" }}}

" provides a buffer line which looks like the tab line
Plug 'ap/vim-buftabline' 
" {{{

    let g:buftabline_indicators = 1
    let g:buftabline_numbers = 2

    nmap <leader>1 <Plug>BufTabLine.Go(1)
    nmap <leader>2 <Plug>BufTabLine.Go(2)
    nmap <leader>3 <Plug>BufTabLine.Go(3)
    nmap <leader>4 <Plug>BufTabLine.Go(4)
    nmap <leader>5 <Plug>BufTabLine.Go(5)
    nmap <leader>6 <Plug>BufTabLine.Go(6)
    nmap <leader>7 <Plug>BufTabLine.Go(7)
    nmap <leader>8 <Plug>BufTabLine.Go(8)
    nmap <leader>9 <Plug>BufTabLine.Go(9)
    nmap <leader>0 <Plug>BufTabLine.Go(10)

    hi! link BufTabLineCurrent   TablineSel
    hi! link BufTabLineActive    TablineSel
    hi! link BufTabLineHidden    Tabline
    hi! link BufTabLineFill      TablineFill

" }}}

Plug 'jreybert/vimagit', { 'on': 'MagitOnly' }
" {{{

    nnoremap <leader>gc :MagitOnly<cr>

" }}}

Plug 'plasticboy/vim-markdown' 
" {{{

    let g:vim_markdown_conceal = 2
    let g:vim_markdown_folding_disabled = 1
    let g:vim_markdown_no_default_key_mappings = 1
    let g:vim_markdown_fenced_languages = ['c','cpp','go','javascript=js','python','java','objc','objcpp', 'make','vim','cmake','bash=sh']

    hi! link mkdString        Normal
    hi! link mkdCode          Keyword
    hi! link mkdCodeDelimiter Delimiter
    hi! link mkdCodeStart     Delimiter
    hi! link mkdCodeEnd       Delimiter
    hi! link mkdFootnote      Normal
    hi! link mkdBlockquote    Normal
    hi! link mkdListItem      Normal
    hi! link mkdRule          Normal
    hi! link mkdLineBreak     Delimiter
    hi! link mkdFootnotes     Normal
    hi! link mkdLink          Keyword
    hi! link mkdURL           Comment
    hi! link mkdInlineURL     Comment
    hi! link mkdID            Normal
    hi! link mkdLinkDef       Normal
    hi! link mkdLinkDefTarget Normal
    hi! link mkdLinkTitle     Keyword
    hi! link mkdDelimiter     Delimiter
    hi! link mkdHeading       Delimiter
    hi! link htmlH1           Keyword

" }}}

Plug 'skywind3000/asyncrun.vim', { 'on': 'AsyncRun' }
" {{{

    let g:asyncrun_open = 8

    nnoremap <leader>b :call AsyncMake()<cr>
    nnoremap <leader>f :AsyncRun rg --vimgrep 

    function! AsyncMake()
        exec ':AsyncStop'
        sleep 1000m
        exec ':AsyncRun make -j8'
    endfunction

" }}}

Plug 'ap/vim-readdir'

Plug 'brooth/far.vim', { 'on': 'Far' }
" {{{

    nnoremap <leader>s :Far 

    let g:far#source = 'rgnvim'
    let g:far#window_layout = 'current'
    let g:far#file_mask_favorites = ['c','cpp','js']
    let g:far#collapse_result = 1
    let g:far#auto_preview = 0

    hi def link FarSearchVal DiffText
    hi def link FarReplaceVal DiffAdd
    hi def link FarReplacedItem DiffAdd
    hi def link FarExcludedItem Comment

" }}}

Plug 'sakhnik/nvim-gdb', { 'branch': 'legacy', 'on': ['GdbStart', 'GdbStartLLDB'] }

Plug 'easymotion/vim-easymotion'
" {{{

    nmap f <Plug>(easymotion-prefix)

" }}}

call plug#end()

" }}}
