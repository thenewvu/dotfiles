if exists("b:current_syntax")
	finish
endif

syn keyword Keyword continue break return case switch default async await function
syn keyword StorageClass const var let new
syn keyword PreProc export import
syn keyword Conditional if else switch
syn keyword Repeat do while for foreach of in
syn match Keyword "[\?\:]"

syn match Function "\v[a-zA-Z_][a-zA-Z0-9_]*\s*(\()@="

syn keyword Operator instantof

syn match Operator "[\+\-\*\/\%\&\|\<\>\=\!\.\]\[]" display

syn match Delimiter "[\)\(\}\{\;\,\\]" display

syn match Number "\d*\.\d\+"

syn region Comment start="//" skip="\\$" end="$" keepend
syn region Comment start="/\*" end="\*/" extend

syn region String start="\"" skip="\\." end="\"" keepend

let b:current_syntax = "javascript"
