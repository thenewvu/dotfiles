if exists("b:current_syntax")
	finish
endif

syn match PreProc "#def"
syn match PreProc "#define"
syn match PreProc "#include"
syn match PreProc "#if"
syn match PreProc "#ifndef"
syn match PreProc "#else"
syn match PreProc "#endif"
syn match PreProc "#pragma once"

syn keyword StorageClass extern const static inline restrict
syn keyword StorageClass auto volatile register __attribute__
syn keyword Structure struct enum
syn keyword Keyword continue break return typedef case label
syn keyword Conditional if else switch
syn keyword Repeat do while for
syn match Keyword "?"
syn match Keyword ":"

syn keyword Type int long short char void signed unsigned float double bool
syn match Type "\v<[a-zA-Z_][a-zA-Z0-9_]*_t>"

syn match Function "\v[a-zA-Z_][a-zA-Z0-9_]*(\()@="

syn keyword Operator sizeof typeof auto_type __typeof __auto_type

syn match Operator "+"
syn match Operator "-"
syn match Operator "*"
syn match Operator "/"
syn match Operator "%"
syn match Operator "&"
syn match Operator "|"
syn match Operator "<"
syn match Operator ">"
syn match Operator "="
syn match Operator "!"

syn match Delimiter ")"
syn match Delimiter "("
syn match Delimiter "}"
syn match Delimiter "{"
syn match Delimiter ";"
syn match Delimiter ","
syn match Delimiter "\]"
syn match Delimiter "\["
syn match Delimiter "\."

syn match Number "\d*\.\d\+"

syn region Comment start="//" skip="\\$" end="$" keepend
syn region Comment start="/\*" end="\*/" extend

syn region String start="\"" skip="\\." end="\"" keepend

let b:current_syntax = "c"
