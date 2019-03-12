" vim:fileencoding=utf-8:foldmethod=marker:foldmarker={{{,}}}

" General {{{

set nobackup nowritebackup noswapfile
set undofile undolevels=500 undoreload=500
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
set diffopt+=algorithm:patience,iwhiteall,iblank,iwhiteeol
set nolist listchars=tab:\│\ ,trail:␣
set shortmess+=c
set splitbelow splitright

" Set %% to the dir that contains the current file
" http://vim.wikia.com/wiki/Easy_edit_of_files_in_the_same_directory
cabbr <expr> %% fnamemodify(resolve(expand('%:p')), ':h')

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
function! OptimizeForLargeFile()
    if getfsize(expand("<afile")) > 1024 * 512 " 512kb
        " no syntax highlighting etc
        set eventignore+=FileType
        " save memory when other file is viewed
        setlocal bufhidden=unload
        " is read-only (write with :w new_filename)
        setlocal buftype=nowrite
        " no undo possible
        setlocal undolevels=-1
    endif
endfunction

augroup All
    au!

    " speed up editing large files
    au BufReadPre * call OptimizeForLargeFile()

    " auto resource $MYVIMRC on change
    au BufWritePost $MYVIMRC source %

    " better recognizing markdown files
    au BufRead,BufNewFile *.markdown set filetype=markdown
    au BufRead,BufNewFile *.md       set filetype=markdown
    au BufRead,BufNewFile *.MD       set filetype=markdown

    au TermOpen * setlocal signcolumn="no"
    au TermOpen * :startinsert
augroup END

" }}}

" Keys {{{

let mapleader = ";"

" write current file with sudo
cmap w! w !sudo tee > /dev/null %
nnoremap ;; :
" close current buffer without closing the current window
nnoremap <A-q> :bp<bar>sp<bar>bn<bar>bd<cr>
" close current window
nnoremap <A-w> :close<cr>
" close current buffer without closing the current window
tnoremap <A-q> <C-\><C-N>:bp<bar>sp<bar>bn<bar>bd<cr>
nnoremap <f2> :e ~/.config/nvim/init.vim<cr>
" reload current file and redraw
nnoremap <f5> :edit<cr>:redraw<cr>
" jump to begin/end of a line
nnoremap B ^
nnoremap E $
vnoremap B ^
vnoremap E $
" unfold only the current block and remove search hl
nnoremap <space> zxzMzvzz:noh<CR>:<backspace>
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
" navigate between splits and buffers
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
inoremap <A-h> <C-w>h
inoremap <A-j> <C-w>j
inoremap <A-k> <C-w>k
inoremap <A-l> <C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
" exit terminal mode
tnoremap <A-space> <C-\><C-n>
" move left/right one indent
nnoremap > >>
nnoremap < <<
vnoremap < <gv
vnoremap > >gv
" open terminal
nnoremap <A-t> :term<cr>
" split vertically
nnoremap <A-\> :vsplit<cr>
" split horizontally
nnoremap <A--> :split<cr>

" star search and keep cursor loc
nmap <silent> * *<C-o>

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


" create/toggle a terminal window at very bottom
" https://pastebin.com/FjdkegRH
" {{{

" Toggle 'default' terminal
nnoremap <A-`> :call ChooseTerm("terminal", 1)<CR>
tnoremap <A-`> <C-\><C-n>:call ChooseTerm("terminal", 1)<CR>
 
function! ChooseTerm(termname, slider)
    let pane = bufwinnr(a:termname)
    let buf = bufexists(a:termname)
    if pane > 0
        " pane is visible
        if a:slider > 0
            :exe pane . "wincmd c"
        else
            :exe "e #"
        endif
    elseif buf > 0
        " buffer is not in pane
        if a:slider
            :exe "topleft split"
        endif
        :exe "buffer " . a:termname
    else
        " buffer is not loaded, create
        if a:slider
            :exe "topleft split"
        endif
        :terminal
        :exe "f " a:termname
    endif
endfunction

" }}}


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
  nnoremap ` :FZF<cr>
  " fuzzy search text in the current buffer
  nnoremap <tab> :BLines<cr>

  augroup FZF
    au!
    " <esc> to close fzf window
    au TermOpen term://*FZF tnoremap <silent> <buffer><nowait> <esc> <c-c>
  augroup end

" }}}

" wb word by word
Plug 'chaoren/vim-wordmotion' 

" automatically add end tag
Plug 'alvan/vim-closetag' 
" {{{

  let g:closetag_filenames = "*.html,*.xml,*.js,*.jsx"

" }}}

" auto add )}]'" after ({['"
Plug 'jiangmiao/auto-pairs'

Plug 'terryma/vim-multiple-cursors' 
" {{{

  hi link multiple_cursors_cursor Cursor
  hi link multiple_cursors_visual Search

" }}}

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

" }}}

Plug 'junegunn/vim-easy-align' 
" {{{

  xmap ga <Plug>(EasyAlign)

" }}}

" async linting
Plug 'w0rp/ale' 
" {{{

    let g:ale_fix_on_save = 1
    let g:ale_open_list = 0
    let g:ale_set_loclist = 1
    let g:ale_lint_on_save = 1
    let g:ale_lint_on_enter = 0
    let g:ale_lint_on_text_changed = 0
    let g:ale_lint_on_filetype_changed = 0
    let g:ale_warn_about_trailing_whitespace = 0
    let g:ale_completion_enabled = 0

    let g:ale_set_highlights = 1
    let g:ale_set_signs = 0
    hi link ALEError       SpellBad
    hi link ALEWarning     SpellLocal

    let g:ale_c_parse_compile_commands = 1

    let g:ale_linters = {}
    let g:ale_linters['c'] = ['clangd']
    let g:ale_linters['cpp'] = ['clangd']
    let g:ale_linters['markdown'] = ['markdownlint']

    let g:ale_fixers = {}
    let g:ale_fixers['c'] = ['clang-format', 'trim_whitespace']
    let g:ale_c_clangformat_options = '-style=file -assume-filename=file.c'
    let g:ale_fixers['cpp'] = ['clang-format', 'trim_whitespace']
    let g:ale_cpp_clangformat_options = '-style=file -assume-filename=file.cpp'
    let g:ale_fixers['javascript'] = ['prettier']
    let g:ale_fixers['json'] = ['prettier']
    let g:ale_javascript_prettier_options = '--parser json'

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

    nmap <F7> <Plug>(ale_previous_wrap)
    nmap <F9> <Plug>(ale_next_wrap)
    nmap <F10> <Plug>(ale_go_to_definition)

" }}}

Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/asyncomplete-file.vim'
"{{{

    let g:asyncomplete_smart_completion = 1
    let g:lsp_diagnostics_enabled = 0

    augroup AsyncComplete
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

    nmap <F11> <Plug>(lsp-rename)
    nmap <F12> <Plug>(lsp-code-action)

"}}}

Plug 'Yggdroot/indentLine' 
" {{{

  let g:indentLine_enabled = 1
  let g:indentLine_faster = 1
  let g:indentLine_bufTypeExclude = ['help', 'terminal']
  let g:indentLine_fileTypeExclude = ['markdown', 'git', 'json']
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
  
" }}}

" provides a buffer line which looks like the tab line
Plug 'ap/vim-buftabline' 
" {{{

    let g:buftabline_indicators = 1
    let g:buftabline_numbers = 2

    nmap <A-1> <Plug>BufTabLine.Go(1)
    nmap <A-2> <Plug>BufTabLine.Go(2)
    nmap <A-3> <Plug>BufTabLine.Go(3)
    nmap <A-4> <Plug>BufTabLine.Go(4)
    nmap <A-5> <Plug>BufTabLine.Go(5)
    nmap <A-6> <Plug>BufTabLine.Go(6)
    nmap <A-7> <Plug>BufTabLine.Go(7)
    nmap <A-8> <Plug>BufTabLine.Go(8)
    nmap <A-9> <Plug>BufTabLine.Go(9)
    nmap <A-0> <Plug>BufTabLine.Go(10)
    tmap <A-1> <C-\><C-n><Plug>BufTabLine.Go(1)
    tmap <A-2> <C-\><C-n><Plug>BufTabLine.Go(2)
    tmap <A-3> <C-\><C-n><Plug>BufTabLine.Go(3)
    tmap <A-4> <C-\><C-n><Plug>BufTabLine.Go(4)
    tmap <A-5> <C-\><C-n><Plug>BufTabLine.Go(5)
    tmap <A-6> <C-\><C-n><Plug>BufTabLine.Go(6)
    tmap <A-7> <C-\><C-n><Plug>BufTabLine.Go(7)
    tmap <A-8> <C-\><C-n><Plug>BufTabLine.Go(8)
    tmap <A-9> <C-\><C-n><Plug>BufTabLine.Go(9)
    tmap <A-0> <C-\><C-n><Plug>BufTabLine.Go(10)


    hi! link BufTabLineCurrent   Normal
    hi! link BufTabLineActive    TablineSel
    hi! link BufTabLineHidden    Tabline
    hi! link BufTabLineFill      TablineFill

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
    let g:asyncrun_open = 10

    nnoremap ! :AsyncRun<space>
    nnoremap <A-f> :AsyncRun! rg --vimgrep 

" }}}

Plug 'easymotion/vim-easymotion'
"{{{

    let g:EasyMotion_do_mapping = 0
    let g:EasyMotion_smartcase = 1

    map f <Plug>(easymotion-overwin-f)

"}}}"

call plug#end()

" }}}
