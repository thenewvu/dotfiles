if exists("b:current_syntax")
	finish
endif

syn keyword Keyword return async await function class case default break continue throw
syn keyword StorageClass const var let new
syn keyword PreProc export import from
syn keyword Conditional if else switch
syn keyword Repeat do while for foreach of in
syn keyword Operator typeof instanceof
syn match Keyword "[\?\:]"

syn match Function "\v[a-zA-Z_][a-zA-Z0-9_]*\s*(\()@="

syn keyword Operator instantof

syn match Operator "[\+\-\*\/\%\&\|\<\>\=\!\.\]\[]" display

syn match Delimiter "[\)\(\}\{\;\,\\]" display

syn match Number "\d*\.\d\+"

syn region Comment start="//" skip="\\$" end="$" keepend
syn region Comment start="/\*" end="\*/" extend

syn match String /\v([''"`])((\\\1|.){-})\1/

let b:current_syntax = "javascript"
