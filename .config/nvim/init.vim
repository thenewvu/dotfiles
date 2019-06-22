 " vim:fileencoding=utf-8:foldmethod=marker:foldmarker={{{,}}}

" General {{{

set nobackup nowritebackup noswapfile
set undofile undolevels=5000 undoreload=5000
set confirm " ask to confirm closing an unsaved file
set hidden " switch between buffers without saving
set completeopt=menu,menuone,noselect,noinsert
set encoding=utf-8
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
set nofoldenable
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
set autoindent smartindent cindent
set cinkeys=0{,0},0),0#,!^F,o,O,e
set cinoptions=t0,j1,J1,m1,(s,{0,L0,g0
set lazyredraw
set synmaxcol=320
set diffopt+=algorithm:patience,iwhiteall,iblank,iwhiteeol
set nolist listchars=tab:\│\ ,trail:␣
set shortmess+=c
set splitbelow splitright

" Set %% to the dir that contains the current file
" http://vim.wikia.com/wiki/Easy_edit_of_files_in_the_same_directory
cabbr <expr> %% fnamemodify(resolve(expand('%:p')), ':h')

function! OnTabEnter(path)
  if isdirectory(a:path)
    let dirname = a:path
  else
    let dirname = fnamemodify(a:path, ":h")
  endif
  execute "tcd ". dirname
endfunction()


augroup All
    au!

    " auto resource $MYVIMRC on change
    au BufWritePost $MYVIMRC source %

    " better recognizing markdown files
    au BufRead,BufNewFile *.markdown set filetype=markdown
    au BufRead,BufNewFile *.md       set filetype=markdown
    au BufRead,BufNewFile *.MD       set filetype=markdown

    au TermOpen * setlocal signcolumn="no"
    au BufWinEnter,WinEnter term://* startinsert

    " https://dmerej.info/blog/post/vim-cwd-and-neovim/
    au TabNewEntered * call OnTabEnter(expand("<amatch>"))
augroup END

" }}}

" Keys {{{

let mapleader = ";"

" write current file with sudo
cmap w! w !sudo tee > /dev/null %
nnoremap <leader>e :e 
nnoremap <f2> :e ~/.config/nvim/init.vim<cr>
" reload current file and redraw
nnoremap <f5> :edit<cr>:redraw<cr>
" jump to begin/end of a line
nnoremap B ^
nnoremap E $
vnoremap B ^
vnoremap E $
nnoremap H 0
nnoremap L $
vnoremap H 0
vnoremap L $
" clear search hl
nnoremap <esc><esc> :noh<cr>
" toggle folding
nnoremap <space> zxzMzvzz
" vertical center movement
nnoremap G Gzz
vnoremap G Gzz
nnoremap gg ggzz
vnoremap gg ggzz
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
" navigate between splits and buffers
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l
inoremap <C-h> <C-w>h
inoremap <C-j> <C-w>j
inoremap <C-k> <C-w>k
inoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" split vertically
nnoremap <C-d> :vsplit<cr>
" split horizontally
nnoremap <C-s> :split<cr>
" close current window
nnoremap <C-q> <C-w>c
" move left/right one indent
nnoremap > >>
nnoremap < <<
vnoremap < <gv
vnoremap > >gv
" star search and keep cursor loc
nmap <silent> * *<C-o>
" copy/paste to/from system clipboard
" https://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
vmap gy "+y
vmap gd "+d
nmap gp "+p
nmap gP "+P
vmap gp "+p
vmap gP "+P
" select text just pasted
" https://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
noremap gvp `[v`]
" multiple lines multiple times with simple ppppp
" https://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]
" avoid accidentally showing command history window when quiting
map q: :q
" <r> keep replacing
nnoremap r R
" newline without enter inserting mode
nnoremap o o<esc>
nnoremap O O<esc>

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


function! ToggleQuickFix()
  if exists("g:qwindow")
    cclose
    unlet g:qwindow
  else
    try
      copen 10
      let g:qwindow = 1
    catch 
      echo "No Errors found!"
    endtry
  endif
endfunction
nnoremap <silent> <F12> :call ToggleQuickFix()<CR>

" }}}

" Plugins {{{

" vim-plug {{{

call plug#begin('~/.config/nvim/plugged')

" fuzzy searching
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim' 

" wb word by word
Plug 'chaoren/vim-wordmotion' 

" automatically add end tag
Plug 'alvan/vim-closetag' 

Plug 'terryma/vim-multiple-cursors' 

Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeEnable' }

Plug 'airblade/vim-gitgutter' 

Plug 'godlygeek/tabular', { 'on': 'Tabularize' }

Plug 'prettier/vim-prettier', { 'do': 'npm install', 'for': ['javascript', 'css', 'json', 'markdown', 'html', 'svg', 'xml'] }

Plug 'neoclide/coc.nvim', {'do': 'npm install'} 

Plug 'Yggdroot/indentLine' 

Plug 'thenewvu/vim-colors-blueprint' 

Plug 'simnalamburt/vim-mundo', { 'on': 'MundoToggle' }

" provides a buffer line which looks like the tab line
Plug 'ap/vim-buftabline' 

Plug 'plasticboy/vim-markdown' 

Plug 'skywind3000/asyncrun.vim', { 'on': 'AsyncRun' }

Plug 'RRethy/vim-hexokinase', { 'on': 'HexokinaseToggle' }

Plug 'kana/vim-smartinput'

Plug 'terryma/vim-expand-region'

Plug 'tikhomirov/vim-glsl', { 'for': 'glsl' }

Plug 'mhinz/vim-hugefile'

call plug#end()

" }}}

" coc.nvim {{{

nmap <silent> <F9> <Plug>(coc-diagnostic-prev)
nmap <silent> <F7> <Plug>(coc-diagnostic-next)
nmap <silent> <F10> <Plug>(coc-definition)
nmap <silent> <F11> <Plug>(coc-implementation)

" }}}

" fzf {{{

  " fuzzy search files in cwd
  nnoremap ` :FZF<cr>
  " fuzzy search text in cur buf
  nnoremap <tab> :BLines<cr>

  augroup FZF
    au!
    " <esc> to close fzf window
    au TermOpen term://*FZF tnoremap <silent> <buffer><nowait> <esc> <c-c>
  augroup end

" }}}

" vim-closetab {{{

  let g:closetag_filenames = "*.html,*.xml,*.js,*.jsx"

" }}}

" vim-multiple-cursors {{{

  hi link multiple_cursors_cursor Cursor
  hi link multiple_cursors_visual Search

" }}}

" vim-gitguter {{{

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

" }}}

" tabular {{{

    vnoremap ga :Tabularize /

" }}}

" indentLine {{{

  let g:indentLine_enabled = 1
  let g:indentLine_faster = 1
  let g:indentLine_bufTypeExclude = ['help', 'terminal']
  let g:indentLine_fileTypeExclude = ['markdown', 'git', 'json']
  let g:indentLine_char = '│'
  let g:indentLine_color_gui = '#2c4e6c'
  let g:indentLine_bgcolor_gui = 'none'

" }}}

" vim-colors-blueprint {{{

  " set rtp+=~/.config/nvim/plugged/vim-colors-blueprint
  set termguicolors
  set background=dark
  colorscheme blueprint

" }}}

" vim-mundo {{{

  let g:mundo_width = 120
  let g:mundo_preview_height = 20
  
" }}}

" vim-buftabline {{{

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
    nnoremap <leader>q :bp<bar>sp<bar>bn<bar>bd<cr>

    hi! link BufTabLineCurrent   Normal
    hi! link BufTabLineActive    TablineSel
    hi! link BufTabLineHidden    Tabline
    hi! link BufTabLineFill      TablineFill

" }}}

" vim-markdown {{{

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

" asyncrun.vim {{{
    let g:asyncrun_open = 10

    nnoremap ! :AsyncRun<space>
    nnoremap <leader>f :AsyncRun! rg --vimgrep 
    nnoremap <F8> :AsyncRun! make %:r<cr>

" }}}

" vim-hexokinase {{{
    let g:Hexokinase_virtualText = '██████'
" }}}

" vim-expand-region {{{

    vmap = <Plug>(expand_region_expand)
    vmap - <Plug>(expand_region_shrink)

" }}}

" python-syntax {{{

    let g:python_highlight_operators = 1

" }}}




" }}}


" }}}


