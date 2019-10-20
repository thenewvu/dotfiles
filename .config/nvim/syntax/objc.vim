if exists("b:current_syntax")
	finish
endif

runtime! syntax/c.vim

" @interface, @end, @implementation, ...
syn match Keyword /\v\@[a-z]+>/ 

syn keyword Keyword super self

syn keyword Type BOOL id

syn match String /\v(#include\s+)@<=\<.+\>/
syn match String /\v(#import\s+)@<=\<.+\>/

" [[self openGLContext] flushBuffer];
syn match Function '\v\s+\zs[a-z][a-zA-Z0-9_]+\ze\s*\]'
" initWithFrame:win_rect
syn match Function '\v<[a-z][a-zA-Z0-9_]+>\ze\s*:'
" - (void)prepareOpenGL
syn match Function '\(^\s*[-+]\s*(\_[^)]*)\)\@<=\_\s*\_\k\+'

let b:current_syntax = "objc"
