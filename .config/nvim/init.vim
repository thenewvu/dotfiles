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
set wildignore+=.hg,.git,.svn,*.class,*.o,*~,*.pyc,*.lock,*.out,*.exe
set wildignorecase " Ignore case when completing filenames
set wildoptions=pum
set nowrap breakindent linebreak breakindentopt=shift:-2
set showbreak=↳\ 
set fillchars+=fold:\ ,diff:\ 
set updatetime=2000
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
set laststatus=0
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
set diffopt=filler,indent-heuristic,algorithm:histogram,iwhite,context:999
set shortmess+=c
set splitbelow splitright

" Set %% to the dir that contains the current file
" http://vim.wikia.com/wiki/Easy_edit_of_files_in_the_same_directory
cabbr <expr> %% fnamemodify(resolve(expand('%:p')), ':h')

function! TabCD(path)
    if isdirectory(a:path)
        let l:dirname = a:path
    else
        let l:dirname = fnamemodify(a:path, ":h")
    endif
    execute "tcd ". l:dirname
endfunction

set foldtext=repeat('\ ',indent(v:foldstart)).'…'
set foldmethod=indent
set foldminlines=3

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

    " clear message below statusline after CursorHold time
    au CursorHold * echo
augroup END

function! FileRename()
    let old_name = expand('%')
    let new_name = input('FileRename: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction

command! FileRename call FileRename()

function! FileDelete()
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

nnoremap <A-e> :e 
vnoremap <A-e> <esc>:e 
inoremap <A-e> <esc>:e 
tnoremap <A-e> <C-\><C-n>:e 

nnoremap <silent> <A-w> :silent w<cr>
vnoremap <silent> <A-w> <esc>:silent w<cr>
inoremap <silent> <A-w> <esc>:silent w<cr>
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
nnoremap <silent> <esc> :noh<cr>
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
nnoremap <A-j> Lzz
nnoremap <A-k> Hzz
vnoremap <A-j> Lzz
vnoremap <A-k> Hzz
" break lines
nnoremap J i<enter><esc>
" join lines
nnoremap K J
nnoremap L <c-i>zvzz
nnoremap H <c-o>zvzz
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
nnoremap <silent> <C-d> :vsplit<cr>
inoremap <silent> <C-d> <esc>:vsplit<cr>
vnoremap <silent> <C-d> <esc>:vsplit<cr>
tnoremap <silent> <C-d> <C-\><C-n>:vsplit<cr>
" split horizontally
nnoremap <silent> <C-s> :split<cr>
inoremap <silent> <C-s> <esc>:split<cr>
vnoremap <silent> <C-s> <esc>:split<cr>
tnoremap <silent> <C-s> <C-\><C-n>:split<cr>
" close other splits
nnoremap <silent> <C-a> :only<cr>
inoremap <silent> <C-a> <esc>:only<cr>
vnoremap <silent> <C-a> <esc>:only<cr>
tnoremap <silent> <C-a> <C-\><C-n>:only<cr>
" close current window
nnoremap <silent> <C-q> <C-w>c
inoremap <silent> <C-q> <esc><C-w>c
vnoremap <silent> <C-q> <esc><C-w>c
tnoremap <silent> <C-q> <C-\><C-n><C-w>c
" move left/right one indent
nnoremap > >>
nnoremap < <<
vnoremap < <gv
vnoremap > >gv
" copy/paste to/from system clipboard
" https://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
vnoremap gy "+y
nnoremap gp "+p`[v`]=`]
nnoremap gP "+P`[v`]=`]
vnoremap gp "+p
vnoremap gP "+P
" multiple lines multiple times with simple ppppp
" https://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
" `[v`] to select pasted text
" = to reindent selecting
" `] to put cursor at the end of pasted text
vnoremap <silent> y y`]
nnoremap <silent> p p`[v`]=`]
nnoremap <silent> P P`[v`]=`]
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
let g:mc = "y/\\V\<C-r>=escape(@\", '/')\<CR>\<CR>"
nnoremap q *``cgn
vnoremap <expr> q g:mc . "``cgn"
" trigger completion
inoremap <A-space> <C-x><C-o>

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

nnoremap <silent> <F12> :call ToggleQuickFix()<CR>
inoremap <silent> <F12> <esc>:call ToggleQuickFix()<CR>
vnoremap <silent> <F12> <esc>:call ToggleQuickFix()<CR>

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
        setlocal nobuflisted
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

function! TerminalExecMake()
    call TerminalExec('make ' . fnamemodify(expand("%:p:h"), ":~:.") . '/')
endfunction

nnoremap <silent> <A-b> :call TerminalExecMake()<cr>
inoremap <silent> <A-b> <esc>:call TerminalExecMake()<cr>
vnoremap <silent> <A-b> <esc>:call TerminalExecMake()<cr>

augroup FORMATER
    au!

    au FileType json,css,html,xml
                \ nnoremap <buffer> gq :PrettierAsync<cr>
augroup end

function ToggleFolding()
    if &foldenable
        set nofoldenable
    else
        set foldenable
    endif
endfunction

nnoremap <F3> :call ToggleFolding()<cr>

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

Plug 'godlygeek/tabular', { 'on': 'Tabularize' }

Plug 'prettier/vim-prettier', { 'do': 'npm install', 'for': ['javascript', 'css', 'json', 'markdown', 'html', 'svg', 'xml'] }

Plug 'thenewvu/vim-colors-blueprint' 

Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }

Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }

" auto complete pairs () [] {} "" ''
Plug 'kana/vim-smartinput'

Plug 'tikhomirov/vim-glsl', { 'for': 'glsl' }

Plug 'mhinz/vim-hugefile'

Plug 'amadeus/vim-convert-color-to', { 'on': 'ConvertColorTo' }

Plug 'skywind3000/asyncrun.vim', { 'on': ['AsyncRun', 'AsyncStop'] }

Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'

" Plug 'ap/vim-buftabline' 
Plug 'pacha/vem-tabline' 

Plug 'endaaman/vim-case-master', { 'on': 'CaseMasterConvertToSnake' }

" Plug 'dahu/vim-fanfingtastic'

Plug 'terryma/vim-expand-region'

Plug 'rhysd/clever-f.vim'

Plug 'Konfekt/FastFold'

Plug 'norcalli/nvim-colorizer.lua', { 'on': 'ColorizerAttachToBuffer' }

Plug 'Yggdroot/indentLine'

" for more pleasant editing on commit messages
Plug 'rhysd/committia.vim'

Plug 'tpope/vim-fugitive'

call plug#end()

" }}}

" vim-commentary {{{

augroup COMMENTARY
    au!
    au FileType c,cpp,objc,go,java,javascript,json,rust,css,glsl
                \ setlocal	commentstring=//%s
augroup end

" }}}

" fzf {{{

command! FzfQuickFix call <SID>FzfQuickFix()
command! FzfLocList call <SID>FzfLocList()
command! FzfLines call <SID>FzfLines()

function! s:FzfQuickFix() abort
    let items = map(getqflist(), {idx, item ->
                \ string(idx).' '.bufname(item.bufnr).' '.item.text})
    call s:FzfPick(items, 'cc', '--with-nth 2.. --reverse')
endfunction

function! s:FzfLocList() abort
    let items = map(getloclist(0), {idx, item ->
                \ string(idx).' '.bufname(item.bufnr).' '.item.text})
    call s:FzfPick(items, 'll', '--with-nth 2.. --reverse')
endfunction

function! s:FzfLines() abort
    let items = map(getline(1, '$'), 'printf("%s %s", v:key, v:val)')
    call s:FzfPick(items, '', '--with-nth 2.. --reverse --prompt "> "')
endfunction

function! s:FzfPick(items, jump, options) abort
    call fzf#run({
                \ 'source': a:items,
                \ 'sink': function('<SID>FzfJump',
                \ [a:jump]),
                \ 'options': a:options,
                \ 'down': '40%'})
endfunction

function! s:FzfJump(jump, item) abort
    let idx = split(a:item, ' ')[0]
    execute a:jump idx + 1
    normal! zvzz
endfunction

command! -bang BTags
            \ call fzf#vim#buffer_tags('', {
            \     'down': '40%',
            \     'options': '--with-nth 1 
            \                 --reverse 
            \                 --prompt "> " 
            \                 --preview-window="80%" 
            \                 --preview "
            \                     tail -n +\$(echo {3} | tr -d \";\\\"\") {2} |
            \                     head -n 16"'
            \ })

" fuzzy search files in cwd
nnoremap <silent> ` :FZF<cr>
" fuzzy search text in cur buf
nnoremap <silent> / :FzfLines<cr>
" fuzzy search tags in cur buf
nnoremap <silent> <tab> :BTags<cr>

augroup FZF
    au!
    " <esc> to close fzf window
    au TermOpen term://*FZF tnoremap <silent> <buffer><nowait> <esc> <c-c>
augroup end

" }}}

" tabular {{{

vnoremap <A-a> :Tabularize /

" }}}

" vim-colors-blueprint {{{

" set rtp+=~/.config/nvim/plugged/vim-colors-blueprint
set termguicolors
set background=dark
colorscheme blueprint

" }}}

" " vim-buftabline {{{

" let g:buftabline_indicators = 1
" let g:buftabline_numbers = 2

" nmap <A-1> <Plug>BufTabLine.Go(1)
" nmap <A-2> <Plug>BufTabLine.Go(2)
" nmap <A-3> <Plug>BufTabLine.Go(3)
" nmap <A-4> <Plug>BufTabLine.Go(4)
" nmap <A-5> <Plug>BufTabLine.Go(5)
" nmap <A-6> <Plug>BufTabLine.Go(6)
" nmap <A-7> <Plug>BufTabLine.Go(7)
" nmap <A-8> <Plug>BufTabLine.Go(8)
" nmap <A-9> <Plug>BufTabLine.Go(9)
" nmap <A-0> <Plug>BufTabLine.Go(10)
" nmap <silent> <A-q> :bp<bar>sp<bar>bn<bar>bd<cr>
" nmap <silent> <A-n> :bn<cr>
" nmap <silent> <A-p> :bp<cr>
" nmap <silent> <A-tab> :b#<cr>

" imap <A-1> <esc><Plug>BufTabLine.Go(1)
" imap <A-2> <esc><Plug>BufTabLine.Go(2)
" imap <A-3> <esc><Plug>BufTabLine.Go(3)
" imap <A-4> <esc><Plug>BufTabLine.Go(4)
" imap <A-5> <esc><Plug>BufTabLine.Go(5)
" imap <A-6> <esc><Plug>BufTabLine.Go(6)
" imap <A-7> <esc><Plug>BufTabLine.Go(7)
" imap <A-8> <esc><Plug>BufTabLine.Go(8)
" imap <A-9> <esc><Plug>BufTabLine.Go(9)
" imap <A-0> <esc><Plug>BufTabLine.Go(10)
" imap <silent> <A-q> <esc>:bp<bar>sp<bar>bn<bar>bd<cr>
" imap <silent> <A-n> <esc>:bn<cr>
" imap <silent> <A-p> <esc>:bp<cr>
" imap <silent> <A-tab> <esc>:b#<cr>

" vmap <A-1> <esc><Plug>BufTabLine.Go(1)
" vmap <A-2> <esc><Plug>BufTabLine.Go(2)
" vmap <A-3> <esc><Plug>BufTabLine.Go(3)
" vmap <A-4> <esc><Plug>BufTabLine.Go(4)
" vmap <A-5> <esc><Plug>BufTabLine.Go(5)
" vmap <A-6> <esc><Plug>BufTabLine.Go(6)
" vmap <A-7> <esc><Plug>BufTabLine.Go(7)
" vmap <A-8> <esc><Plug>BufTabLine.Go(8)
" vmap <A-9> <esc><Plug>BufTabLine.Go(9)
" vmap <A-0> <esc><Plug>BufTabLine.Go(10)
" vmap <silent> <A-q> <esc>:bp<bar>sp<bar>bn<bar>bd<cr>
" vmap <silent> <A-n> <esc>:bn<cr>
" vmap <silent> <A-p> <esc>:bp<cr>
" vmap <silent> <A-tab> <esc>:b#<cr>

" tmap <A-1> <C-\><C-n><Plug>BufTabLine.Go(1)
" tmap <A-2> <C-\><C-n><Plug>BufTabLine.Go(2)
" tmap <A-3> <C-\><C-n><Plug>BufTabLine.Go(3)
" tmap <A-4> <C-\><C-n><Plug>BufTabLine.Go(4)
" tmap <A-5> <C-\><C-n><Plug>BufTabLine.Go(5)
" tmap <A-6> <C-\><C-n><Plug>BufTabLine.Go(6)
" tmap <A-7> <C-\><C-n><Plug>BufTabLine.Go(7)
" tmap <A-8> <C-\><C-n><Plug>BufTabLine.Go(8)
" tmap <A-9> <C-\><C-n><Plug>BufTabLine.Go(9)
" tmap <A-0> <C-\><C-n><Plug>BufTabLine.Go(10)
" tmap <silent> <A-q> <C-\><C-n>:bd<cr>
" tmap <silent> <A-n> <C-\><C-n>:bn<cr>
" tmap <silent> <A-p> <C-\><C-n>:bp<cr>
" tmap <silent> <A-tab> <C-\><C-n>:b#<cr>

" hi! link BufTabLineCurrent   TablineSel
" hi! link BufTabLineActive    Tabline
" hi! link BufTabLineHidden    Tabline
" hi! link BufTabLineFill      TablineFill

" " }}}

" vem-tabline {{{

let g:vem_tabline_show_number = 'index'
let g:vem_tabline_show = 2 " always show

nmap <silent><A-1> :VemTablineGo 1<cr>
nmap <silent><A-2> :VemTablineGo 2<cr>
nmap <silent><A-3> :VemTablineGo 3<cr>
nmap <silent><A-4> :VemTablineGo 4<cr>
nmap <silent><A-5> :VemTablineGo 5<cr>
nmap <silent><A-6> :VemTablineGo 6<cr>
nmap <silent><A-7> :VemTablineGo 7<cr>
nmap <silent><A-8> :VemTablineGo 8<cr>
nmap <silent><A-9> :VemTablineGo 9<cr>
nmap <silent><A-q> :bp<bar>bd#<cr>
nmap <silent><A-n> <Plug>vem_next_buffer-
nmap <silent><A-p> <Plug>vem_prev_buffer-
nmap <silent><A-tab> :b#<cr>
nmap <silent><A-P> <Plug>vem_move_buffer_left-
nmap <silent><A-N> <Plug>vem_move_buffer_right-
nmap <silent><A-C-p> gT
nmap <silent><A-C-n> gt
nmap <silent><A-C-q> :tabclose<cr>

imap <silent><A-1> <esc>:VemTablineGo 1<cr>
imap <silent><A-2> <esc>:VemTablineGo 2<cr>
imap <silent><A-3> <esc>:VemTablineGo 3<cr>
imap <silent><A-4> <esc>:VemTablineGo 4<cr>
imap <silent><A-5> <esc>:VemTablineGo 5<cr>
imap <silent><A-6> <esc>:VemTablineGo 6<cr>
imap <silent><A-7> <esc>:VemTablineGo 7<cr>
imap <silent><A-8> <esc>:VemTablineGo 8<cr>
imap <silent><A-9> <esc>:VemTablineGo 9<cr>
imap <silent><A-q> <esc>:bp<bar>bd#<cr>
imap <silent><A-n> <esc><Plug>vem_next_buffer-
imap <silent><A-p> <esc><Plug>vem_prev_buffer-
imap <silent><A-tab> <esc>:b#<cr>
imap <silent><A-C-p> <esc>gT
imap <silent><A-C-n> <esc>gt
imap <silent><A-C-q> <esc>:tabclose<cr>

vmap <silent><A-1> <esc>:VemTablineGo 1<cr>
vmap <silent><A-2> <esc>:VemTablineGo 2<cr>
vmap <silent><A-3> <esc>:VemTablineGo 3<cr>
vmap <silent><A-4> <esc>:VemTablineGo 4<cr>
vmap <silent><A-5> <esc>:VemTablineGo 5<cr>
vmap <silent><A-6> <esc>:VemTablineGo 6<cr>
vmap <silent><A-7> <esc>:VemTablineGo 7<cr>
vmap <silent><A-8> <esc>:VemTablineGo 8<cr>
vmap <silent><A-9> <esc>:VemTablineGo 9<cr>
vmap <silent><A-q> <esc>:bp<bar>bd#<cr>
vmap <silent><A-n> <esc><Plug>vem_next_buffer-
vmap <silent><A-p> <esc><Plug>vem_prev_buffer-
vmap <silent><A-tab> <esc>:b#<cr>
vmap <silent><A-C-p> <esc>gT
vmap <silent><A-C-n> <esc>gt
vmap <silent><A-C-q> <esc>:tabclose<cr>

tmap <silent><A-1> <C-\><C-n>:VemTablineGo 1<cr>
tmap <silent><A-2> <C-\><C-n>:VemTablineGo 2<cr>
tmap <silent><A-3> <C-\><C-n>:VemTablineGo 3<cr>
tmap <silent><A-4> <C-\><C-n>:VemTablineGo 4<cr>
tmap <silent><A-5> <C-\><C-n>:VemTablineGo 5<cr>
tmap <silent><A-6> <C-\><C-n>:VemTablineGo 6<cr>
tmap <silent><A-7> <C-\><C-n>:VemTablineGo 7<cr>
tmap <silent><A-8> <C-\><C-n>:VemTablineGo 8<cr>
tmap <silent><A-9> <C-\><C-n>:VemTablineGo 9<cr>
tmap <silent><A-q> <C-\><C-n>:bp<bar>bd#<cr>
tmap <silent><A-n> <C-\><C-n><Plug>vem_next_buffer-
tmap <silent><A-p> <C-\><C-n><Plug>vem_prev_buffer-
tmap <silent><A-tab> <C-\><C-n>:b#<cr>
tmap <silent><A-C-p> <C-\><C-n>gT
tmap <silent><A-C-n> <C-\><C-n>gt
tmap <silent><A-C-q> <C-\><C-n>:tabclose<cr>

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

" python-syntax {{{

let g:python_highlight_operators = 1

" }}}

" vim-hugefile {{{

let g:hugefile_trigger_size = 0.4

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
vnoremap <A-s> y<esc>:AsyncRun! rg --vimgrep --fixed-strings "<c-r>""<cr>
tnoremap <A-s> <C-\><C-n>:AsyncRun! rg --vimgrep  

nnoremap <A-f> :AsyncRun! rg --vimgrep <cword><cr>
vnoremap <A-f> y<esc>:AsyncRun! rg --vimgrep --fixed-strings "<c-r>""<cr>

" }}}

" vim-lsp {{{

" let g:lsp_log_file = expand('/tmp/vim-lsp.log')
let g:lsp_auto_enable = 0
let g:lsp_text_document_did_save_delay = 0
let g:lsp_semantic_enabled = 0
let g:lsp_auto_enable = 0
let g:lsp_signs_enabled = 0
let g:lsp_text_edit_enabled = 0
let g:lsp_signature_help_enabled = 0
let g:lsp_diagnostics_echo_cursor = 0
let g:lsp_diagnostics_float_cursor = 0
let g:lsp_highlight_references_enabled = 0

hi link LspErrorHighlight Underlined
hi link LspWarningHighlight Underlined
hi link LspInformationHighlight Underlined
hi link LspHintHighlight Underlined

hi link LspErrorText Error
hi link LspWarningText WarningMsg
hi link LspInformationText Search
hi link LspHintText Search

augroup VIM_LSP
    au!
    if executable('clangd')
        au User lsp_setup call lsp#register_server({
                    \ 'name': 'clangd',
                    \ 'cmd': {server_info->['clangd', '-background-index', '-limit-results=20']},
                    \ 'whitelist': ['c', 'cpp', 'objc'],
                    \ })
        au FileType c,cpp,objc call lsp#enable()
        au FileType c,cpp,objc noremap <buffer> <A-e> :LspNextError<cr>
        au FileType c,cpp,objc noremap <buffer> <A-E> :LspPreviousError<cr>
        au FileType c,cpp,objc nnoremap <buffer> <A-i> :LspHover<cr>
        au FileType c,cpp,objc inoremap <buffer> <A-i> <esc>:LspSignatureHelp<cr>
        au FileType c,cpp,objc nnoremap <buffer> <A-r> :LspRename<cr>
        au FileType c,cpp,objc nnoremap <buffer> <A-t> :LspDocumentDiagnostics<cr>
        au FileType c,cpp,objc setlocal omnifunc=lsp#complete
    endif
augroup END

" }}}

" vim-case-master {{{

nnoremap _ :CaseMasterConvertToSnake<cr>

" }}}

" smartinput {{{

call smartinput#define_rule({
            \ 'at': '(\%#)',
            \ 'char': '<Enter>',
            \ 'input': '<Enter><Enter><BS><Up><Esc>"_S'
            \ })

" }}}

" vim-expand-region {{{

map vv <Plug>(expand_region_expand)
map vV <Plug>(expand_region_shrink)

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

nnoremap <esc><esc> <Plug>(clever-f-reset)

hi! link CleverFDefaultLabel SpellBad

" }}}

" fastfold {{{

let g:fastfold_fold_command_suffixes = []
let g:fastfold_fold_movement_commands = []
let g:fastfold_skip_filetypes = [ 'git', 'diff' ]

" }}}

" indentLine {{{

let g:indentLine_enabled = 0
let g:indentLine_color_gui = '#2c4e6c'
let g:indentLine_char = '│'

augroup IndentLine
    au!
    au FileType c,cpp,objc,javascript,java :IndentLinesEnable
augroup end

" }}}

" vim-glsl {{{

augroup GLSL
    au!
    au BufRead *.vert set syntax=glsl
    au BufRead *.frag set syntax=glsl
augroup END

" }}}

" committia.vim {{{

    augroup Committia
        au!
        au FileType git set foldenable foldmethod=syntax foldtext=getline(v:foldstart)
    augroup END

" }}}

" }}}

if &diff
    syntax off
    filetype off
endif

