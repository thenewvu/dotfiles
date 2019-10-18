if exists("b:current_syntax")
	finish
endif

runtime! syntax/c.vim

" @interface, @end, @implementation, ...
syn match Keyword /\v\@[a-z]+>/ 

syn keyword Keyword super self autorelease

syn keyword Type BOOL

syn match String /\v(#include\s+)@<=\<.+\>/
syn match String /\v(#import\s+)@<=\<.+\>/

" [[self openGLContext] flushBuffer];
syn match Function '\(\[\s*\k\+\s\+\|\]\s*\)\@<=\k*\s*\]'me=e-1
" [view initWithFrame:win_rect pixelFormat:pxfmt];
syn match Function '\(\_\S\+\_\s\+\)\@<=[a-z][a-zA-Z0-9_]\+\s*:'
" - (void)prepareOpenGL {
syn match Function '\(^\s*[-+]\s*(\_[^)]*)\)\@<=\_\s*\_\k\+'

let b:current_syntax = "objc"
