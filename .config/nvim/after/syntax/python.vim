syn clear

setlocal foldmethod=syntax

syn keyword pythonStatement		as assert break continue del exec global
syn keyword pythonStatement		lambda nonlocal pass print return with yield
syn keyword pythonConditional	elif else if
syn keyword pythonRepeat		for while
syn keyword pythonOperator		and in is not or
syn match 	pythonOperator 		'\V=\|-\|+\|*\|@\|/\|%\|&\||\|^\|~\|<\|>\|!='
syn keyword pythonException		except finally raise try
syn keyword pythonInclude		from import
syn keyword pythonAsync			async await

syn match   pythonDecorator	"@" display contained
syn match   pythonDecoratorName	"@\s*\h\%(\w\|\.\)*" display contains=pythonDecorator

syn match   pythonComment	"#.*$" contains=pythonTodo,@Spell
syn keyword pythonTodo		FIXME NOTE NOTES TODO XXX contained

syn match   pythonEscape	+\\[abfnrtv'"\\]+ contained
syn match   pythonEscape	"\\\o\{1,3}" contained
syn match   pythonEscape	"\\x\x\{2}" contained
syn match   pythonEscape	"\%(\\u\x\{4}\|\\U\x\{8}\)" contained
" Python allows case-insensitive Unicode IDs: http://www.unicode.org/charts/
syn match   pythonEscape	"\\N{\a\+\%(\s\a\+\)*}" contained
syn match   pythonEscape	"\\$"

syn region  pythonClassOrDef start="^\z(\s*\)\(class\|def\)\s" skip="\(\s*\n\)\+\z1\s\+\(\S\|\%$\)" end="\(\s*\n\)\+\s*\(\S\|\%$\)"me=s-1 transparent fold

syn match 	pythonOperator "[\]\[]"
syn match 	pythonStatement ":"

syn match 	Delimiter "[().,]" display

syn match 	pythonFunction "\<\k\+\ze(" display

hi def link pythonStatement		Statement
hi def link pythonConditional	Conditional
hi def link pythonRepeat		Repeat
hi def link pythonOperator		Operator
hi def link pythonException		Exception
hi def link pythonInclude		Include
hi def link pythonAsync			Statement
hi def link pythonDecorator		Define
hi def link pythonDecoratorName	Function
hi def link pythonFunction		Function
hi def link pythonComment		Comment
hi def link pythonTodo			Todo
hi def link pythonString		String
hi def link pythonRawString		String
hi def link pythonQuotes		String
hi def link pythonTripleQuotes	pythonQuotes
hi def link pythonEscape		Special


