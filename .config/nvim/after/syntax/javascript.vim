syn match Operator	"\(<<\|>>\|[-+*/%&^|<>!=]\)="
syn match Operator	"<<\|>>\|&&\|||\|++\|--\|->"
syn match Operator	"[.!~*&%<>^|=+-]"
syn match Operator	"/[^/*=]"me=e-1
syn match Operator	"/$"
syn match Operator "&&\|||"
syn match Operator "[\]\[]"

syn keyword Keyword	function
syn keyword Operator new var

syn match Delimiter "[();\\{},]" display
syn match Function "\<\k\+\ze(" display

hi! link Noise Delimiter
hi! link javaScriptNull Type
