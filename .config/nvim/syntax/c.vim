if exists("b:current_syntax")
	finish
endif

syn match PreProc /\v^\s*\#\s*[a-z]+>/ 
syn keyword PreProc __attribute__ Generic
syn keyword StorageClass extern static inline const restrict volatile register
syn keyword Keyword continue break return case default goto typedef
syn keyword Conditional if else switch
syn keyword Repeat do while for
syn keyword Type void unsigned signed long int short char double float
syn match Type /\vstruct\s+[a-zA-Z0-9_]+>/
syn match Type /\venum\s+[a-zA-Z0-9_]+>/
syn match Structure "\v^\s*(struct|enum|union)(\s*[a-zA-Z0-9_]*\_s*\{)@="

syn keyword Operator sizeof __sizeof
syn match Operator "[\+\-\*\/\%\?\:\&\|\<\>\=\!\.]"
syn match Operator "\v[a-zA-Z_#][#a-zA-Z0-9_]{-}\s*(\()@="
syn match Type /\v<[a-zA-Z0-9_]+_t>/
syn keyword Type auto_type __auto_type
syn match Type "\v_?_?typeof\(.{-}\)"

syn match Delimiter "[\)\(\}\{\;\,\\]"
syn match Delimiter "\vassert\(.{-}\)"

syn match Number "\v\d{-}\.\d+"
syn match Label "\v^\s*[a-zA-Z0-9_]{-}\s*:\s*$"

syn region Comment start="//" skip="\\$" end="$"
syn region Comment start="/\*" end="\*/"
syn match Todo "\v\s{-}\/\/\s{-}(TODO|NOTE|FIXME)\:.{-}$"

syn match String /\v([''"`])((\\\1|.){-})\1/
syn match String /\v(#include\s+)@<=\<.+\>/

let b:current_syntax = "c"
