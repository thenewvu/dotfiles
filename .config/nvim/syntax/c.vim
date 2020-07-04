if exists("b:current_syntax")
	finish
endif

syn match PreProc /\v^\s*\#\s*[a-z]+>/ 
syn keyword PreProc __attribute__
syn keyword StorageClass extern static inline const restrict auto volatile register
syn keyword Keyword continue break return case default goto typedef
syn keyword Conditional if else switch
syn keyword Repeat do while for
syn match Structure "\v^\s*(struct|enum|union)(\s*[a-zA-Z0-9_]*\_s*\{)@="

syn keyword Operator sizeof __sizeof typeof __typeof assert __Generic auto_type __auto_type
syn match Operator "[\+\-\*\/\%\?\:\&\|\<\>\=\!\.\]\[]"
syn match Operator "\v[a-zA-Z_#][#a-zA-Z0-9_]{-}\s*(\()@="

syn match Delimiter "[\)\(\}\{\;\,\\]"

syn match Number "\v\d{-}\.\d+"
syn match Label "\v^\s*[a-zA-Z0-9_]{-}\s*:\s*$"

syn region Comment start="//" skip="\\$" end="$"
syn region Comment start="/\*" end="\*/"
syn match Todo "\v\s{-}\/\/\s{-}[A-Z]+\:.{-}$"

syn match String /\v([''"`])((\\\1|.){-})\1/
syn match String /\v(#include\s+)@<=\<.+\>/

let b:current_syntax = "c"
