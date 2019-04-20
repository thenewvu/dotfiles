syn match Operator	"\(<<\|>>\|[-+*/%&^|<>!=]\)="
syn match Operator	"<<\|>>\|&&\|||\|++\|--\|->"
syn match Operator	"[.!~*&%<>^|=+-]"
syn match Operator	"/[^/*=]"me=e-1
syn match Operator	"/$"
syn match Operator "&&\|||"
syn match Operator "[\]\[]"
syn match Function "\<\k\+\ze(" display
syn match Delimiter "[{}().,;]" display
