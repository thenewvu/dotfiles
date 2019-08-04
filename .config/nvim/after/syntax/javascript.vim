syn match Operator	"\(<<\|>>\|[-+*/%&^|<>!=]\)="
syn match Operator	"<<\|>>\|&&\|||\|++\|--\|->"
syn match Operator	"[.!~*&%<>^|=+-]"
syn match Operator	"/[^/*=]"me=e-1
syn match Operator	"/$"
syn match Operator "&&\|||"
syn match Operator "[\]\[]"

syn keyword Keyword	function async await new
syn keyword StorageClass var let const

syn match Delimiter "[();\\{},]" display
syn match Function "\<\k\+\ze(" display

hi! link Noise Delimiter
hi! link javaScriptNull Type
