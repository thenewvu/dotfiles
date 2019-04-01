syn match cOperator	"\(<<\|>>\|[-+*/%&^|<>!=]\)="
syn match cOperator	"<<\|>>\|&&\|||\|++\|--\|->"
syn match cOperator	"[!~*&%<>^|=+-]"
syn match cOperator	"/[^/*=]"me=e-1
syn match cOperator	"/$"
syn match cOperator "&&\|||"

syn match Delimiter "[.();\\{},\[\]\"\']" display
syn match Delimiter "->" display

syn keyword Debug assert asserteq case

syn match Define "^\s*\zs\(%:\|#\)\s*\(define\|undef\)\>"
