
syn match cOperator	"\(<<\|>>\|[-+*/%&^|<>!=]\)="
syn match cOperator	"<<\|>>\|&&\|||\|++\|--\|->"
syn match cOperator	"[.!~*&%<>^|=+-]"
syn match cOperator	"/[^/*=]"me=e-1
syn match cOperator	"/$"
syn match cOperator "&&\|||"
syn match cOperator "[\]\[]"

syn keyword	cOperator	__typeof __auto_type

syn match Delimiter "[();\\{},]" display
syn match Define "^\s*\zs\(%:\|#\)\s*\(define\|undef\)\>"

syn match Function "\<\k\+\ze\s*(" display

syn clear cConstant

syn match Keyword "[?:]"

hi! link cUserCont Delimiter
