syn match cOperator	"\(<<\|>>\|[-+*/%&^|<>!=]\)="
syn match cOperator	"<<\|>>\|&&\|||\|++\|--\|->"
syn match cOperator	"[.!~*&%<>^|=+-]"
syn match cOperator	"/[^/*=]"me=e-1
syn match cOperator	"/$"
syn match cOperator "&&\|||"
syn match cOperator "[\]\[]"
syn match Delimiter "[();\\{},\"\']" display
syn match Define "^\s*\zs\(%:\|#\)\s*\(define\|undef\)\>"

" hl 'case' and 'default' as cStatement

" https://github.com/TUSSON/.vim/blob/master/syntax/c.vim
syn match cFunction "\<\h\w*\>\(\s\|\n\)*("me=e-1 contains=cType,cDelimiter,cDefine
hi! link cFunction function

syn match cMacro "\<\(_\|\u\)\+\(\u\|\d\|_\)*\>"
syn keyword	cOperator	__typeof __auto_type

hi! link cUserCont Delimiter
