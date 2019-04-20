syn match cOperator	"\(<<\|>>\|[-+*/%&^|<>!=]\)="
syn match cOperator	"<<\|>>\|&&\|||\|++\|--\|->"
syn match cOperator	"[.!~*&%<>^|=+-]"
syn match cOperator	"/[^/*=]"me=e-1
syn match cOperator	"/$"
syn match cOperator "&&\|||"
syn match cOperator "[\]\[]"
syn match Delimiter "[();\\{},]" display
syn match Define "^\s*\zs\(%:\|#\)\s*\(define\|undef\)\>"

syn keyword	cOperator	__typeof __auto_type
syn match Function "\<\k\+\ze(" display

hi! link cUserCont Delimiter
