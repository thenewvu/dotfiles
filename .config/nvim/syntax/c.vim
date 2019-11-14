if exists("b:current_syntax")
	finish
endif

syn match PreProc /\v\#\s*[a-z]+>/ 

syn keyword StorageClass extern const static inline restrict auto_type __auto_type
syn keyword StorageClass auto volatile register __attribute__
syn keyword Structure struct enum union
syn keyword Keyword continue break return typedef case default
syn keyword Conditional if else switch
syn keyword Repeat do while for
syn match Keyword "?"
syn match Keyword ":"

syn keyword Type int long short char void signed unsigned float double bool
syn match Type "\v<[a-zA-Z_][a-zA-Z0-9_]*_t>"

syn match Function "\v[a-zA-Z_][a-zA-Z0-9_]*\s*(\()@="

syn keyword Operator sizeof typeof typeof

syn match Operator "[\+\-\*\/\%\&\|\<\>\=\!\.\]\[]" display

syn match Delimiter "[\)\(\}\{\;\,\\]" display

syn match Number "\d*\.\d\+"

syn region Comment start="//" skip="\\$" end="$" keepend
syn region Comment start="/\*" end="\*/" extend

syn region String start="\"" skip="\\." end="\"" keepend
syn match String /\v(#include\s+)@<=\<.+\>/

let b:current_syntax = "c"
