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

syn keyword Keyword return async await function class case default
syn keyword Keyword break continue throw try catch finally
syn keyword StorageClass const
syn keyword PreProc export import from
syn keyword Conditional if else switch
syn keyword Repeat do while for foreach of in
syn keyword Operator typeof instanceof var let new delete
syn match Function "\v[a-zA-Z_][a-zA-Z0-9_]*\s*(\()@="
syn match Operator "[\?\:\+\-\*\/\%\&\|\<\>\=\!\.]"
syn match Delimiter "[\}\{\;\,\\\(\)\[\]]" display
syn match Number "\d*\.\d\+"
syn region Comment start="//" skip="\\$" end="$" keepend
syn region Comment start="/\*" end="\*/" extend
syn match Todo "\v\s{-}\/\/\s{-}(TODO|NOTE|FIXME)\:.{-}$"
syn match String /\v([''"`])((\\\1|.){-})\1/

let b:current_syntax = "javascript"

if main_syntax == 'javascript'
  unlet main_syntax
endif

let &cpo = s:cpo_save
unlet s:cpo_save

