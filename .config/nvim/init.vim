" vim:fileencoding=utf-8:foldmethod=marker:foldmarker={{{,}}}

" General {{{
set nobackup nowritebackup noswapfile
set undofile undolevels=10000 undoreload=10000
set confirm " ask to confirm closing an unsaved file
set hidden " switch between buffers without saving
set completeopt=menu,menuone,noselect,noinsert
set encoding=utf-8
set autoread " autoreload files on change
set backspace=indent,eol,start " make backspace work like most other apps
set incsearch hlsearch noignorecase
set inccommand=nosplit " live substitution
set gdefault " %s//g by default
set expandtab smarttab tabstop=4 shiftwidth=4 softtabstop=4 
set wildignore+=.hg,.git,.svn,*.class,*.o,*~,*.pyc,*.lock,*.out,*.exe
set wildignorecase " Ignore case when completing filenames
set wildoptions=pum
set nowrap breakindent linebreak breakindentopt=shift:-2
set showbreak=↳\ 
set fillchars+=fold:\ ,diff:\ 
set updatetime=1000
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
let g:sh_no_error=1
set statusline=%F%m
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
set diffopt=filler,indent-heuristic,algorithm:histogram,iwhite,context:999
set shortmess+=c
set splitbelow splitright
set foldmethod=syntax
set foldtext=MyFoldText()
set regexpengine=1

" Set %% to the dir that contains the current file
" http://vim.wikia.com/wiki/Easy_edit_of_files_in_the_same_directory
cabbr <expr> %% fnamemodify(resolve(expand('%:p')), ':h')

function! TabCD(path) abort
    if isdirectory(a:path)
        let l:dirname = a:path
    else
        let l:dirname = fnamemodify(a:path, ":h")
    endif
    execute "tcd ". l:dirname
endfunction

function! MyFoldText() abort
    return repeat(' ', indent(v:foldstart)) . trim(getline(v:foldstart)) . '…' . trim(getline(v:foldend))
endfunction

function! MyFoldExprC() abort
    let l:text = getline(v:lnum)
    " remove strings and regexs
    let l:text = substitute(l:text, '\v([''"`\/])((\\\1|.){-})\1', '', 'g')
    " remove after last opening {
    let l:text = substitute(l:text, '\v\{[^\{\}]*\}', "", "g")

    " both opening and closing
    if l:text =~# '^[^{]\{-}}.\{-}{[^}]*$'
        return '='
        " opening
    elseif l:text =~# '^.\{-}{[^}]*$'
        return 'a1'
        " closing
    elseif l:text =~# '^[^{]\{-}}.*$'
        return 's1'
    endif

    return '='
endfunction

augroup All
    au!

    " dont highlight searching matches during inserting
    au InsertEnter * :setlocal nohlsearch
    au InsertLeave * :setlocal hlsearch
    au TermEnter * :setlocal nohlsearch
    au TermLeave * :setlocal hlsearch

    au TermOpen * setlocal signcolumn="no"

    " https://dmerej.info/blog/post/vim-cwd-and-neovim/
    au TabNewEntered * call TabCD(expand("<amatch>"))

    au FileType c,cpp,javascript,java,go,objc,objcpp,dart,rust
                \ setlocal foldmethod=expr
                \ foldexpr=MyFoldExprC()

    " https://vi.stackexchange.com/a/169
    let g:huge_file_size = 1024 * 512 " 512KB
    au BufReadPre *
            \ let f=expand("<afile>") |
            \ if getfsize(f) > g:huge_file_size |
                    \ set eventignore+=FileType |
                    \ setlocal undolevels=-1 |
            \ else |
                    \ set eventignore-=FileType |
            \ endif
augroup END

function! FileRename() abort
    let old_name = expand('%')
    let new_name = input('FileRename: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction

command! FileRename call FileRename()

function! FileDelete() abort
    let filepath = expand('%')
    let answer = input('Are you sure to delete ' . filepath . '? ')
    if answer == 'y'
        exec ':bd'
        exec ':silent !rm ' . filepath
    endif
endfunction

command! FileDelete call FileDelete()

" }}}

" Keys {{{

nnoremap = V=
nnoremap m %
vnoremap m %
" jump to begin/end of a line
nnoremap B ^
nnoremap E $
vnoremap B ^
vnoremap E $
" clear search hl
nnoremap <silent> <esc> :echo<cr>:noh<cr>
" toggle folding
nnoremap <space> zMzvzz
" nnoremap z zx
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
nnoremap K J
nnoremap J i<enter><esc>
" redo
nnoremap U <c-r>
" move left/right one indent
nnoremap > >>
nnoremap < <<
vnoremap < <gv
vnoremap > >gv
" reselect pasted text
nnoremap vp `[v`]
" reselect last selected text
nnoremap vv gv
" start replacing in selected text
vnoremap s :s/
" reselect last selected text then start replacing
nnoremap vs gv:s/
" copy/paste to/from system clipboard
" https://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
nnoremap gy V"+y
vnoremap gy "+y
nnoremap gp "+p`]
nnoremap gP "+P`]
vnoremap gp "+p
vnoremap gP "+P
" multiple lines multiple times with simple ppppp
" https://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
" `] to put cursor at the end of pasted text
vnoremap y y`]
nnoremap p p`]
nnoremap P P`]
" paste in visual mode without reyanking
" https://stackoverflow.com/a/5093286
vnoremap p pgvy`]
" newline without enter inserting mode
nnoremap o o<esc>
nnoremap O O<esc>
" multiple cursors
" http://www.kevinli.co/posts/2017-01-19-multiple-cursors-in-500-bytes-of-vimscript/
let g:mc = "y/\\V\<C-r>=escape(@\", '/')\<CR>\<CR>"
nnoremap r *``cgn
vnoremap <expr> r g:mc . "``cgn"
" record macro to w register
nnoremap q qw
" replay macro from w register
nnoremap Q @w
" search without jumping
" https://stackoverflow.com/a/4262209
nnoremap * :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>
vnoremap * :<C-U>
            \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
            \gvy:let @/=substitute(
            \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR>
            \gV:call setreg('"', old_reg, old_regtype)<CR>:set hls<CR>
" jump back/forward last cursor pos
nnoremap L <c-i>zvzz
nnoremap H <c-o>zvzz
nnoremap \\ :call ToggleQuickFix()<CR>
nnoremap M :call ToggleFolding()<CR>zz

" switch to last active buffer before closing the current one
" to avoid changing window layout
nnoremap <A-q> :bp<bar>bd#<cr> 
" faster scrolling
nnoremap <A-j> Lzz
nnoremap <A-k> Hzz
vnoremap <A-j> Lzz
vnoremap <A-k> Hzz
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
nnoremap <C-d> :vsplit<cr>
inoremap <C-d> <esc>:vsplit<cr>
vnoremap <C-d> <esc>:vsplit<cr>
tnoremap <C-d> <C-\><C-n>:vsplit<cr>
" close other windows
nnoremap <C-a> :only<cr>
inoremap <C-a> <esc>:only<cr>
vnoremap <C-a> <esc>:only<cr>
tnoremap <C-a> <C-\><C-n>:only<cr>
" close current window
nnoremap <C-q> <C-w>c
inoremap <C-q> <esc><C-w>c
vnoremap <C-q> <esc><C-w>c
tnoremap <C-q> <C-\><C-n><C-w>c

" write current file with sudo
cmap w! w !sudo tee > /dev/null %

nnoremap <F2> :e ~/.config/nvim/init.vim<cr>

function! ToggleQuickFix() abort
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

function ToggleFolding() abort
    if &foldenable
        set nofoldenable
    else
        set foldenable
    endif
endfunction

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

Plug 'junegunn/vim-easy-align'

Plug 'thenewvu/vim-colors-blueprint' 

Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }

Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }

Plug 'kana/vim-smartinput'

Plug 'tikhomirov/vim-glsl', { 'for': 'glsl' }

Plug 'amadeus/vim-convert-color-to', { 'on': 'ConvertColorTo' }

Plug 'skywind3000/asyncrun.vim', { 'on': ['AsyncRun', 'AsyncStop'] }

" Plug 'prabirshrestha/vim-lsp'

Plug 'thosakwe/vim-flutter', { 'on': 'FlutterRun' }

Plug 'neovim/nvim-lsp'
" Plug 'nvim-lua/completion-nvim'

Plug 'endaaman/vim-case-master', { 'on': 'CaseMasterConvertToSnake' }

Plug 'terryma/vim-expand-region'

Plug 'rhysd/clever-f.vim'

Plug 'Konfekt/FastFold'

Plug 'chrisbra/Colorizer', { 'on': ['ColorToggle','ColorHighlight'] }

Plug 'Yggdroot/indentLine'

Plug 'dart-lang/dart-vim-plugin', { 'for': 'dart' }

Plug 'kassio/neoterm'

Plug '907th/vim-auto-save'

Plug 'FooSoft/vim-argwrap'

Plug 'neoclide/vim-jsx-improve'

call plug#end()

" }}}

" 907th/vim-auto-save {{{

let g:auto_save = 1
let g:auto_save_events = ["CursorHold", "CursorHoldI"]
let g:auto_save_write_all_buffers = 1
let g:auto_save_silent = 1

" }}}

" kassio/neoterm {{{

let g:neoterm_autoinsert = 1

nnoremap <A-`> :botright Ttoggle<cr>
inoremap <A-`> <esc>:botright Ttoggle<cr>
vnoremap <A-`> <esc>:botright Ttoggle<cr>
tnoremap <A-`> <C-\><C-n>:botright Ttoggle<cr>

" }}}

" vim-commentary {{{

augroup COMMENTARY
    au!
    au FileType c,cpp,objc,go,java,javascript,json,rust,css,glsl
                \ setlocal	commentstring=//%s
augroup end

" }}}

" fzf {{{

command! -bang -nargs=* FzfBufLines
    \ call fzf#vim#grep('grep --with-filename --line-number . '.fnameescape(expand('%')), 0,
    \   fzf#vim#with_preview({
    \       'options': '--bind change:top --delimiter : --with-nth 3..'
    \       }),
    \   0)

command! -bang -nargs=* FzfTodos
    \ call fzf#vim#grep('grep -e "\(TODO\|FIXME\|NOTE\)" --with-filename --line-number '.fnameescape(expand('%')), 0,
    \   fzf#vim#with_preview({
    \       'options': '--bind change:top --delimiter : --with-nth 3..'
    \       }),
    \   0)

command! -bang FzfBufTags
    \ call fzf#vim#buffer_tags('', {
    \     'options': '--bind change:top
    \                 --with-nth 1
    \                 --reverse
    \                 --prompt "> "
    \                 --preview-window="80%"
    \                 --preview "~/.config/nvim/plugged/fzf.vim/bin/preview.sh {2}:\$(echo {3} | tr -d \";\\\"\")"'
    \ })

nnoremap / :FzfBufLines<cr>
nnoremap <tab> :FzfBufTags<cr>
nnoremap ` :FZF<cr>

nnoremap <A-tab> :Buffers<cr>
tnoremap <A-tab> <C-\><C-n>:Buffers<cr>
inoremap <A-tab> <esc>:Buffers<cr>

nnoremap <F1> :Help<cr>
nnoremap ; :Commands<cr>

augroup FZF
    au!
    " <esc> to close fzf window
    au TermOpen term://*FZF tnoremap <buffer><nowait> <esc> <c-c>
augroup end

" }}}

" junegunn/vim-easy-align {{{

xmap a <Plug>(EasyAlign)

" }}}

" vim-colors-blueprint {{{

" set rtp+=~/.config/nvim/plugged/vim-colors-blueprint
set termguicolors
set background=dark
colorscheme blueprint

" }}}

" vim-markdown {{{

let g:vim_markdown_conceal = 2
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_no_default_key_mappings = 1

let g:vim_markdown_fenced_languages = ['js=javascript']

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

" python-syntax {{{

let g:python_highlight_operators = 1

" }}}

" undotree {{{

let g:undotree_WindowLayout = 2
let g:undotree_SplitWidth = 60

" }}}

" asyncrun {{{

let g:asyncrun_open = 10
let g:asyncrun_local = 0

nnoremap ! :AsyncRun<space>
nnoremap <A-s> :AsyncRun! rg --vimgrep 
inoremap <A-s> <esc>:AsyncRun! rg --vimgrep 
vnoremap <A-s> y<esc>:AsyncRun! rg --vimgrep --fixed-strings "<c-r>""
tnoremap <A-s> <C-\><C-n>:AsyncRun! rg --vimgrep 

" }}}

" " vim-lsp {{{

" let g:lsp_auto_enable = 1
" let g:lsp_fold_enabled = 0
" let g:lsp_text_document_did_save_delay = 0
" let g:lsp_semantic_enabled = 0
" let g:lsp_signs_enabled = 0
" " let g:lsp_text_edit_enabled = 0
" let g:lsp_signature_help_enabled = 0
" let g:lsp_diagnostics_echo_cursor = 0
" let g:lsp_diagnostics_float_cursor = 1
" let g:lsp_virtual_text_enabled = 0
" let g:lsp_highlight_references_enabled = 0
" " let g:lsp_log_file = expand('/tmp/vim-lsp.log')


" hi link LspErrorHighlight Underlined
" hi link LspWarningHighlight Underlined
" hi link LspInformationHighlight Underlined
" hi link LspHintHighlight Underlined

" hi link LspErrorText Error
" hi link LspWarningText WarningMsg
" hi link LspInformationText WarningMsg
" hi link LspHintText WarningMsg

" function! s:on_lsp_buffer_enabled() abort
"     setlocal omnifunc=lsp#complete
"     inoremap <A-space> <C-x><C-o>

"     setlocal statusline=%F%m
"     setlocal statusline+=%=
"     setlocal statusline+=%{lsp#get_buffer_diagnostics_counts().warning}W
"     setlocal statusline+=:
"     setlocal statusline+=%{lsp#get_buffer_diagnostics_counts().error}E
"     nnoremap <buffer> <A-]> :LspNextDiagnostic<cr>
"     nnoremap <buffer> <A-[> :LspPreviousDiagnostic<cr>
"     nnoremap <buffer> <A-i> :LspHover<cr>
"     inoremap <buffer> <A-i> <esc>:LspSignatureHelp<cr>
"     nnoremap <buffer> <A-o> :LspDefinition<cr>
"     inoremap <buffer> <A-o> <esc>:LspDefinition<cr>
"     nnoremap <buffer> <A-\> :LspDocumentDiagnostics<cr>
" endfunction

" augroup VIM_LSP
"     au!
"     au User lsp_buffer_enabled call s:on_lsp_buffer_enabled()

"     if executable('clangd')
"         au User lsp_setup call lsp#register_server({
"             \ 'name': 'clangd',
"             \ 'cmd': {server_info->['clangd', '-background-index']},
"             \ 'allowlist': ['c', 'cpp', 'objc'],
"             \ 'initialization_options': {
"             \   'fallbackFlags': [
"             \       '-xcpp-output',
"             \       '-Wall',
"             \       '-Wextra',
"             \       '-Wno-missing-braces',
"             \       '-Wno-initializer-overrides',
"             \       '-Wno-unused-parameter'
"             \   ]
"             \ },
"             \ })
"     endif

"     if executable('flutter')
"         let s:flutter_bin_path = fnamemodify(system('which flutter'), ':p:h')
"         au User lsp_setup call lsp#register_server({
"             \   'name': 'flutter-dart',
"             \   'cmd': {server_info->[
"             \         s:flutter_bin_path . '/cache/dart-sdk/bin/dart',
"             \         s:flutter_bin_path . '/cache/dart-sdk/bin/snapshots/analysis_server.dart.snapshot',
"             \         '--lsp'
"             \     ]},
"             \   'allowlist': ['dart'],
"             \   'config': {
"             \     'onlyAnalyzeProjectsWithOpenFiles': v:true,
"             \     'suggestFromUnimportedLibraries': v:false
"             \   },
"             \ })
"     endif

"     if executable('typescript-language-server')
"       au User lsp_setup call lsp#register_server({
"         \ 'name': 'typescript-language-server',
"         \ 'cmd': {server_info->['typescript-language-server', '--stdio']},
"         \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'package.json'))},
"         \ 'allowlist': ['javascript', 'javascript.jsx'],
"         \ })
"     endif

" augroup END

" " }}}

" nvim-lsp {{{

lua << EOF
  local lsp = require 'lspconfig'

  lsp.clangd.setup{
    on_attach = on_attach,
    init_options = {
      fallbackFlags = {
        '-xcpp-output',
        '-Wall',
        '-Wextra',
        '-Wno-missing-braces',
        '-Wno-initializer-overrides',
        '-Wno-unused-parameter'
      }
    }
  }
EOF

command! LspDeclaration :lua vim.lsp.buf.declaration()
command! LspDefinition :lua vim.lsp.buf.definition()
command! LspTypeDefinition :lua vim.lsp.buf.type_definition()
command! LspImplementation :lua vim.lsp.buf.implementation()
command! LspHover :lua vim.lsp.buf.hover()
command! LspSignatureHelp :lua vim.lsp.buf.signature_help()
command! LspReferences :lua vim.lsp.buf.references()
command! LspDocumentSymbol :lua vim.lsp.buf.document_symbol()
command! LspWorkspaceSymbol :lua vim.lsp.buf.workspace_symbol()
command! LspFormat :lua vim.lsp.buf.formatting_sync(nil, 1000)
command! LspDocumentDiagnostics :OpenDiagnostic

" https://github.com/pyrho/rc/blob/caf1a22d5c333416873336e71d2fbfcbae96d14b/nvim/conf/50-lightline.vim
function! LspStatus() abort
    if luaeval('not vim.tbl_isempty(vim.lsp.buf_get_clients(0))')
       let errors = luaeval("vim.lsp.diagnostic.get_count(0, 'Error')")
       let warnings = luaeval("vim.lsp.diagnostic.get_count(0, 'Warning')")
       let info = luaeval("vim.lsp.diagnostic.get_count(0, 'Hint')")
       if errors == 0 && warnings == 0
           return ''
       endif
       return '⚠ E' .errors . ' W' . warnings . ' I' . info
    endif
    return ''
endfunction

function! LspBufSetup() abort
    setlocal omnifunc=v:lua.vim.lsp.omnifunc
    setlocal statusline=%F%m%=%{LspStatus()}

    nnoremap <A-i> <cmd>lua vim.lsp.buf.hover()<CR>
    inoremap <A-i> <cmd>lua vim.lsp.buf.signature_help()<CR>
    inoremap <A-space> <C-x><C-o>
    nnoremap ]e <cmd>lua vim.lsp.diagnostic.goto_next()<CR>zz
    nnoremap [e <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>zz
    nnoremap \e <cmd>vim.lsp.diagnostic.set_loclist()<CR>
    
    augroup LSP_BUF
        au!
        au CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
    augroup END
endfunction

augroup LSP
    au!
    au Filetype dart call LspBufSetup()
    au Filetype c,cpp,objc,objcpp call LspBufSetup()
augroup END

lua << EOF
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = false,
    signs = false,
    update_in_insert = false,
  }
)
EOF


" }}}

" dart-lang/dart-vim-plugin {{{

" augroup DART
"     au!
"     au BufWritePre *.dart :DartFmt<cr>
" augroup END

" }}}

" vim-expand-region {{{

map vo <Plug>(expand_region_expand)
map vi <Plug>(expand_region_shrink)

let g:expand_region_text_objects = {
            \ 'i"'  :0,
            \ 'i''' :0,
            \ 'i]'  :1,
            \ 'i)'  :1,
            \ 'i}'  :1,
            \ }

" }}}

" clever-f {{{

let g:clever_f_ignore_case = 1
let g:clever_f_across_no_line = 0
let g:clever_f_fix_key_direction = 1

nmap <esc><esc> <Plug>(clever-f-reset)

hi! link CleverFDefaultLabel SpellBad

" }}}

" fastfold {{{

let g:fastfold_skip_filetypes = [ 'git', 'diff' ]
let g:fastfold_force = 1
let g:fastfold_savehook = 0
let g:fastfold_minlines = 2

" }}}

" indentLine {{{

let g:indentLine_concealcursor=0
let g:indentLine_enabled = 0
let g:indentLine_color_gui = '#2c4e6c'
let g:indentLine_char = '│'

augroup IndentLine
    au!
    au FileType c,cpp,objc,javascript,java,dart :IndentLinesEnable
augroup end

" }}}

" vim-glsl {{{

augroup GLSL
    au!
    au BufRead *.vert set syntax=glsl
    au BufRead *.frag set syntax=glsl
augroup END

" }}}

" wordmotion {{{

	let g:wordmotion_prefix = '_wm'
	let g:wordmotion_mappings = {
	\ 'w' : 'w',
	\ 'b' : 'b',
	\ 'e' : 'e',
	\ }

" }}}

" }}}

if &diff
    syntax off
    filetype off
endif

