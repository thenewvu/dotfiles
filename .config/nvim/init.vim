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
set incsearch hlsearch noignorecase inccommand=nosplit gdefault
set expandtab smarttab tabstop=4 shiftwidth=4 softtabstop=4 
set wildignore+=.hg,.git,.svn,*.class,*.o,*~,*.pyc,*.lock,*.out,*.exe,.*
set wildignorecase " Ignore case when completing filenames
set wildoptions=pum
set nowrap breakindent linebreak breakindentopt=shift:-2
set showbreak=↳\ 
set fillchars+=fold:\ 
set nofoldenable
" disable some builtin plugins
let g:did_install_default_menus = 1
let g:loaded_2html_plugin       = 1
let g:loaded_getscript          = 1
let g:loaded_getscriptPlugin    = 1
let g:loaded_zip                = 1
let g:loaded_zipPlugin          = 1
let g:loaded_gzip               = 1
let g:loaded_tar                = 1
let g:loaded_tarPlugin          = 1
let g:loaded_logiPat            = 1
let g:loaded_netrw              = 1
let g:loaded_netrwFileHandlers  = 1
let g:loaded_netrwPlugin        = 1
let g:loaded_netrwSettings      = 1
let g:loaded_rrhelper           = 1
let g:loaded_vimball            = 1
let g:loaded_vimballPlugin      = 1
let g:loaded_spellfile_plugin   = 1
let g:loaded_tutor_mode_plugin  = 1
let g:loaded_matchparen         = 1
let g:loaded_matchit            = 1
let g:c_syntax_for_h = 1
set laststatus=2
set statusline=%F
set noshowcmd
set noshowmode
set noruler
set nonumber
set signcolumn=auto:2
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

    au TermOpen * setlocal signcolumn="no"

    " https://dmerej.info/blog/post/vim-cwd-and-neovim/
    au TabNewEntered * call OnTabEnter(expand("<amatch>"))

    au VimEnter * delmarks A-Z
    au BufReadPost * delmarks a-z
augroup END

" }}}

" Keys {{{

let mapleader = ";"

nnoremap <A-e> :e 
vnoremap <A-e> <esc>:e 
inoremap <A-e> <esc>:e 
tnoremap <A-e> <C-\><C-n>:e 
nnoremap <A-w> :w<cr>
vnoremap <A-w> <esc>:w<cr>
inoremap <A-w> <esc>:w<cr>
" write current file with sudo
cmap w! w !sudo tee > /dev/null %
nnoremap <f1> :help 
nnoremap <f2> :e ~/.config/nvim/init.vim<cr>
" jump to begin/end of a line
nnoremap B ^
nnoremap E $
vnoremap B ^
vnoremap E $
" clear search hl
nnoremap <esc><esc> :noh<cr>
" toggle folding
nnoremap zz zxzMzvzz
nnoremap <space><space> zA
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
nnoremap <A-j> Lzz
nnoremap <A-k> Hzz
" break lines
nnoremap J i<enter><esc>
" join lines
nnoremap K J
" expand region by word
nmap L ve
vmap L e
" shrink region by word
nmap H vb
vmap H b
" redo
nnoremap U <c-r>
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
inoremap <C-d> <esc>:vsplit<cr>
vnoremap <C-d> <esc>:vsplit<cr>
tnoremap <C-d> <C-\><C-n>:vsplit<cr>
" split horizontally
nnoremap <C-s> :split<cr>
inoremap <C-s> <esc>:split<cr>
vnoremap <C-s> <esc>:split<cr>
tnoremap <C-s> <C-\><C-n>:split<cr>
" close other splits
nnoremap <C-a> :only<cr>
inoremap <C-a> <esc>:only<cr>
vnoremap <C-a> <esc>:only<cr>
tnoremap <C-a> <C-\><C-n>:only<cr>
" close current window
nnoremap <C-q> <C-w>c
inoremap <C-q> <esc><C-w>c
vnoremap <C-q> <esc><C-w>c
tnoremap <C-q> <C-\><C-n><C-w>c
" move left/right one indent
nnoremap > >>
nnoremap < <<
vnoremap < <gv
vnoremap > >gv
" copy/paste to/from system clipboard
" https://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
vnoremap gy "+y
nnoremap gp "+p
nnoremap gP "+P
vnoremap gp "+p
vnoremap gP "+P
" multiple lines multiple times with simple ppppp
" https://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
vnoremap <silent> y y`]
nnoremap <silent> p p`]
" paste in visual mode without reyanking
" https://stackoverflow.com/a/5093286
vnoremap p pgvy`]
" <r> keep replacing
nnoremap r R
" newline without enter inserting mode
nnoremap o o<esc>
nnoremap O O<esc>
" multiple cursors
" http://www.kevinli.co/posts/2017-01-19-multiple-cursors-in-500-bytes-of-vimscript/
nnoremap q *``cgn
let g:mc = "y/\\V\<C-r>=escape(@\", '/')\<CR>\<CR>"
vnoremap <expr> q g:mc . "``cgn"

" search without jumping
" https://stackoverflow.com/a/4262209
nnoremap <silent> * :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy:let @/=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>:set hls<CR>


function! ToggleQuickFix()
  if exists("g:qwindow")
    cclose
    unlet g:qwindow
  else
    try
      bot copen 10
      let g:qwindow = 1
    catch 
      echo "No Errors found!"
    endtry
  endif
endfunction

nnoremap <silent> <A-tab> :call ToggleQuickFix()<CR>

" https://github.com/kutsan/dotfiles/blob/8b243cd065b90b3d05dbbc71392f1dba1282d777/.vim/autoload/kutsan/mappings.vim#L1-L52
function! TerminalCreateIfNot() abort
	if !has('nvim')
		return v:false
	endif

	if !exists('g:terminal')
		let g:terminal = {
			\ 'loaded': v:null,
			\ 'termbufferid': v:null,
			\ 'originbufferid': v:null,
			\ 'jobid': v:null
		\ }
	endif

	function! g:terminal.on_exit(jobid, data, event)
		silent execute 'buffer' g:terminal.originbufferid
		silent execute 'bdelete!' g:terminal.termbufferid

		let g:terminal = {
			\ 'loaded': v:null,
			\ 'termbufferid': v:null,
			\ 'originbufferid': v:null,
			\ 'jobid': v:null
		\ }
	endfunction

	" Create terminal and finish.
	if !g:terminal.loaded
		let g:terminal.originbufferid = bufnr('')

		enew
        let g:terminal.jobid = termopen(&shell, g:terminal)
		let g:terminal.loaded = v:true
		let g:terminal.termbufferid = bufnr('')

		silent execute 'buffer' g:terminal.originbufferid

		return v:true
	endif
endfunction

function! TerminalToggle() abort
    call TerminalCreateIfNot()

	" Go back to origin buffer if current buffer is terminal.
	if g:terminal.termbufferid ==# bufnr('')
		silent execute 'buffer' g:terminal.originbufferid

	" Launch terminal buffer and start insert mode.
	else
		let g:terminal.originbufferid = bufnr('')
		silent execute 'buffer' g:terminal.termbufferid
		startinsert
	endif
endfunction

" https://gist.github.com/ram535/b1b7af6cd7769ec0481eb2eed549ea23
function! TerminalExec(cmd)
    call TerminalCreateIfNot()

    call jobsend(g:terminal.jobid, a:cmd . "\n")
endfunction

nnoremap <silent> <A-`> :call TerminalToggle()<cr>
inoremap <silent> <A-`> <esc>:call TerminalToggle()<cr>
vnoremap <silent> <A-`> <esc>:call TerminalToggle()<cr>
tnoremap <silent> <A-`> <C-\><C-n>:call TerminalToggle()<cr>

nnoremap <silent> <A-b>      :call TerminalExec('make ' . expand('%:r'))<cr>
inoremap <silent> <A-b> <esc>:call TerminalExec('make ' . expand('%:r'))<cr>
vnoremap <silent> <A-b> <esc>:call TerminalExec('make ' . expand('%:r'))<cr>

" }}}

" Plugins {{{

" vim-plug {{{

call plug#begin('~/.config/nvim/plugged')

" commenting
Plug 'tpope/vim-commentary'

" fuzzy searching
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim' 

" wb word by word
Plug 'chaoren/vim-wordmotion' 

" automatically add end tag
Plug 'alvan/vim-closetag' 

Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeEnable' }

Plug 'airblade/vim-gitgutter' 

Plug 'godlygeek/tabular', { 'on': 'Tabularize' }

Plug 'prettier/vim-prettier', { 'do': 'npm install', 'for': ['javascript', 'css', 'json', 'markdown', 'html', 'svg', 'xml'] }

Plug 'Yggdroot/indentLine' 

Plug 'thenewvu/vim-colors-blueprint' 

Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }

Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }

" hightlight hex colors
Plug 'RRethy/vim-hexokinase', { 'on': 'HexokinaseToggle' }

" auto complete pairs () [] {} "" ''
Plug 'kana/vim-smartinput'

Plug 'tikhomirov/vim-glsl', { 'for': 'glsl' }

Plug 'mhinz/vim-hugefile'

" provide commands on file: Delete, Rename, ...
Plug 'tpope/vim-eunuch'

Plug 'amadeus/vim-convert-color-to', { 'on': 'ConvertColorTo' }

Plug 'skywind3000/asyncrun.vim', { 'on': 'AsyncRun' }

" show marks on signcolumn
Plug 'kshenoy/vim-signature'

Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

Plug 'zefei/vim-wintabs'
Plug 'zefei/vim-wintabs-powerline'

call plug#end()

" }}}

" fzf {{{

function! s:align_lists(lists)
  let maxes = {}
  for list in a:lists
    let i = 0
    while i < len(list)
      let maxes[i] = max([get(maxes, i, 0), len(list[i])])
      let i += 1
    endwhile
  endfor
  for list in a:lists
    call map(list, "printf('%-'.maxes[v:key].'s', v:val)")
  endfor
  return a:lists
endfunction

function! s:btags_source()
  let lines = map(
              \   split(
              \     system(
              \       printf(
              \         'ctags --c-kinds=defgpstuvl -f - --sort=no --excmd=number %s',
              \          expand('%:S')
              \       )
              \     ),
              \     "\n"
              \   ),
              \   'split(v:val, "\t")'
              \ )
  if v:shell_error
    throw 'failed to extract tags'
  endif
  return map(s:align_lists(lines), 'join(v:val, "\t")')
endfunction

function! s:btags_sink(line)
  execute split(a:line, "\t")[2]
endfunction

function! s:btags()
  try
    call fzf#run({
    \ 'source':  s:btags_source(),
    \ 'options': '-d "\t" --with-nth 1 -n 1',
    \ 'down':    '40%',
    \ 'sink':    function('s:btags_sink')})
  catch
    echohl WarningMsg
    echom v:exception
    echohl None
  endtry
endfunction

command! BTags call s:btags()

" fuzzy search files in cwd
nnoremap ` :FZF<cr>
" fuzzy search text in cur buf
nnoremap / :BLines<cr>
nnoremap <tab> :BTags<cr>
nnoremap <space> '

augroup FZF
    au!
    " <esc> to close fzf window
    au TermOpen term://*FZF tnoremap <silent> <buffer><nowait> <esc> <c-c>
augroup end

" }}}

" vim-gitguter {{{

  set updatetime=1000

  let g:gitgutter_diff_args = '-w'
  let g:gitgutter_sign_added = '\ '
  let g:gitgutter_sign_modified = '\ '
  let g:gitgutter_sign_removed = '\ '
  let g:gitgutter_sign_modified_removed = '\ '
  let g:gitgutter_sign_allow_clobber = 0

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

" vim-wintabs {{{

    let g:wintabs_ui_buffer_name_format = '.%o %t'

    hi   link   WintabsEmpty        TablineFill
    hi   link   WintabsActive       Normal
    hi   link   WintabsInactive     Tabline
    hi   link   WintabsArrow        TablineFill
    hi   link   WintabsActiveNC     Normal
    hi   link   WintabsInactiveNC   Tabline

    nmap <A-1> <Plug>(wintabs_tab_1)
    nmap <A-2> <Plug>(wintabs_tab_2)
    nmap <A-3> <Plug>(wintabs_tab_3)
    nmap <A-4> <Plug>(wintabs_tab_4)
    nmap <A-5> <Plug>(wintabs_tab_5)
    nmap <A-6> <Plug>(wintabs_tab_6)
    nmap <A-7> <Plug>(wintabs_tab_7)
    nmap <A-8> <Plug>(wintabs_tab_8)
    nmap <A-9> <Plug>(wintabs_tab_9)
    nmap <A-0> <Plug>(wintabs_tab_10)
    nmap <A-q> <Plug>(wintabs_close)

    imap <A-1> <esc><Plug>(wintabs_tab_1)
    imap <A-2> <esc><Plug>(wintabs_tab_2)
    imap <A-3> <esc><Plug>(wintabs_tab_3)
    imap <A-4> <esc><Plug>(wintabs_tab_4)
    imap <A-5> <esc><Plug>(wintabs_tab_5)
    imap <A-6> <esc><Plug>(wintabs_tab_6)
    imap <A-7> <esc><Plug>(wintabs_tab_7)
    imap <A-8> <esc><Plug>(wintabs_tab_8)
    imap <A-9> <esc><Plug>(wintabs_tab_9)
    imap <A-0> <esc><Plug>(wintabs_tab_10)
    imap <A-q> <esc><Plug>(wintabs_close)

    vmap <A-1> <esc><Plug>(wintabs_tab_1)
    vmap <A-2> <esc><Plug>(wintabs_tab_2)
    vmap <A-3> <esc><Plug>(wintabs_tab_3)
    vmap <A-4> <esc><Plug>(wintabs_tab_4)
    vmap <A-5> <esc><Plug>(wintabs_tab_5)
    vmap <A-6> <esc><Plug>(wintabs_tab_6)
    vmap <A-7> <esc><Plug>(wintabs_tab_7)
    vmap <A-8> <esc><Plug>(wintabs_tab_8)
    vmap <A-9> <esc><Plug>(wintabs_tab_9)
    vmap <A-0> <esc><Plug>(wintabs_tab_10)
    vmap <A-q> <esc><Plug>(wintabs_close)

    tmap <A-1> <C-\><C-n><Plug>(wintabs_tab_1)
    tmap <A-2> <C-\><C-n><Plug>(wintabs_tab_2)
    tmap <A-3> <C-\><C-n><Plug>(wintabs_tab_3)
    tmap <A-4> <C-\><C-n><Plug>(wintabs_tab_4)
    tmap <A-5> <C-\><C-n><Plug>(wintabs_tab_5)
    tmap <A-6> <C-\><C-n><Plug>(wintabs_tab_6)
    tmap <A-7> <C-\><C-n><Plug>(wintabs_tab_7)
    tmap <A-8> <C-\><C-n><Plug>(wintabs_tab_8)
    tmap <A-9> <C-\><C-n><Plug>(wintabs_tab_9)
    tmap <A-0> <C-\><C-n><Plug>(wintabs_tab_10)

    nmap <A-h> <Plug>(wintabs_previous)
    nmap <A-l> <Plug>(wintabs_next)
    imap <A-h> <esc><Plug>(wintabs_previous)
    imap <A-l> <esc><Plug>(wintabs_next)
    vmap <A-h> <esc><Plug>(wintabs_previous)
    vmap <A-l> <esc><Plug>(wintabs_next)
    tmap <A-h> <C-\><C-n><Plug>(wintabs_previous)
    tmap <A-l> <C-\><C-n><Plug>(wintabs_next)

" }}}

" vim-markdown {{{

    let g:vim_markdown_conceal = 2
    let g:vim_markdown_folding_disabled = 1
    let g:vim_markdown_no_default_key_mappings = 1

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

" vim-hexokinase {{{
    let g:Hexokinase_virtualText = '██████'
" }}}

" python-syntax {{{

    let g:python_highlight_operators = 1

" }}}

" vim-hugefile {{{

let g:hugefile_trigger_size = 1

" }}}

" vim-prettier {{{

let g:prettier#config#config_precedence = 'file-override'

" }}}

" undotree {{{

let g:undotree_WindowLayout = 2
let g:undotree_SplitWidth = 60

" }}}

" asyncrun {{{

let g:asyncrun_open = 10

nnoremap ! :AsyncRun<space>
nnoremap <A-s> :AsyncRun! rg --vimgrep 
inoremap <A-s> <esc>:AsyncRun! rg --vimgrep  
vnoremap <A-s> y<esc>:AsyncRun! rg --vimgrep <c-r>"<cr>
tnoremap <A-s> <C-\><C-n>:AsyncRun! rg --vimgrep  

nnoremap <A-f> :AsyncRun! rg --vimgrep <cword><cr>
vnoremap <A-f> y<esc>:AsyncRun! rg --vimgrep <c-r>"<cr>

" }}}

" vim-signature {{{

let g:SignatureMarkTextHL = "WarningMsg"
let g:SignatureMarkOrder = "\m█"
let g:SignatureIncludeMarks = "abcdefghijklmnopqrstuvwxyz"
let g:SignatureMap = {
    \ 'Leader'             :  "m",
    \ 'PlaceNextMark'      :  "",
    \ 'ToggleMarkAtLine'   :  "",
    \ 'PurgeMarksAtLine'   :  "",
    \ 'DeleteMark'         :  "",
    \ 'PurgeMarks'         :  "m<Space>",
    \ 'PurgeMarkers'       :  "",
    \ 'GotoNextLineAlpha'  :  "",
    \ 'GotoPrevLineAlpha'  :  "",
    \ 'GotoNextSpotAlpha'  :  "",
    \ 'GotoPrevSpotAlpha'  :  "",
    \ 'GotoNextLineByPos'  :  "",
    \ 'GotoPrevLineByPos'  :  "",
    \ 'GotoNextSpotByPos'  :  "",
    \ 'GotoPrevSpotByPos'  :  "",
    \ 'GotoNextMarker'     :  "",
    \ 'GotoPrevMarker'     :  "",
    \ 'GotoNextMarkerAny'  :  "",
    \ 'GotoPrevMarkerAny'  :  "",
    \ 'ListBufferMarks'    :  "m/",
    \ 'ListBufferMarkers'  :  ""
    \ }

" }}}

" asyncomplete.vim {{{

let g:asyncomplete_popup_delay = 200

" }}}

" vim-lsp {{{

let g:lsp_signs_enabled = 0
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_highlight_references_enabled = 0
let g:lsp_text_edit_enabled = 0

hi link LspErrorHighlight Underlined
hi link LspWarningHighlight Underlined
hi link LspInformationHighlight Underlined
hi link LspHintHighlight Underlined

hi link LspError Error
hi link LspWarning WarningMsg
hi link LspInformation Comment
hi link LspHint Comment

hi link LspErrorText Error
hi link LspWarningText WarningMsg
hi link LspInformationText Comment
hi link LspHintText Comment

augroup VIM_LSP
    au!
    if executable('clangd')
        au User lsp_setup call lsp#register_server({
            \ 'name': 'clangd',
            \ 'cmd': {server_info->['clangd', '-background-index']},
            \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
            \ })
        au BufReadPost *.h,*.c,*.cpp nnoremap <silent> ]e :LspNextError<cr>
        au BufReadPost *.h,*.c,*.cpp nnoremap <silent> [e :LspPreviousError<cr>
        au BufReadPost *.h,*.c,*.cpp nnoremap <silent> <leader>i :LspHover<cr>
        au BufReadPost *.h,*.c,*.cpp nnoremap <silent> <leader>r :LspRename<cr>
        au BufReadPost *.h,*.c,*.cpp nnoremap <silent> <leader>f :LspDocumentFormat<cr>
    endif
augroup END

" }}}

" }}}


