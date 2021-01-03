if !exists("main_syntax")
  " quit when a syntax file was already loaded
  if exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'javascript'
elseif exists("b:current_syntax") && b:current_syntax == "javascript"
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn keyword Keyword async await
syn keyword Keyword function class extends type interface
syn keyword Keyword return break continue 
syn keyword Exception throw try finally
syn keyword StorageClass const var let
syn keyword PreProc export import as from case default
syn keyword Conditional if else switch
syn keyword Repeat do while for foreach of in
syn keyword Operator typeof instanceof new delete
syn match Function "\v[a-zA-Z_][a-zA-Z0-9_]*\s*(\()@="
syn match Operator "[\+\-\*\/\%\?\:\&\|\<\>\=\!\.\[\]]"
syn match Delimiter "[\)\(\}\{\;\,\\]"
syn match Number "\d*\.\d\+"
syn match Todo "\v\s{-}\/\/\s{-}(TODO|NOTE|FIXME)\:.{-}$"
syn match String /\v([''"`\/])((\\\1|.){-})\1/
syn region Comment start="//" skip="\\$" end="$"
syn region Comment start="/\*" end="\*/"
syn match Todo "\v\s{-}\/\/\s{-}(TODO|NOTE|FIXME)\:.{-}$"
" highlight only catch in try-catch, not obj.catch()
syn match Exception /\v[^\.]\_s*\zscatch/

let b:current_syntax = "javascript"

if main_syntax == 'javascript'
  unlet main_syntax
endif

let &cpo = s:cpo_save
unlet s:cpo_save

