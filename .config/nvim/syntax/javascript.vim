if !exists("main_syntax")
  " quit when a syntax file was already loaded
  if exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'javascript'
elseif exists("b:current_syntax") && b:current_syntax == "javascript"
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn keyword Keyword async await
syn keyword Keyword function class extends
syn keyword Keyword return break continue 
syn keyword Exception throw try finally
syn keyword StorageClass const var let
syn keyword PreProc export import as from case default
syn keyword Conditional if else switch
syn keyword Repeat do while for foreach of in
syn keyword Operator typeof instanceof new delete
syn match Function "\v[a-zA-Z_][a-zA-Z0-9_]*\s*(\()@="
syn match Operator "[\+\-\*\/\%\?\:\&\|\<\>\=\!\.\[\]]"
syn match Delimiter "[\)\(\}\{\;\,\\]"
syn match Number "\d*\.\d\+"
syn match Todo "\v\s{-}\/\/\s{-}(TODO|NOTE|FIXME)\:.{-}$"
syn match String /\v([''"`\/])((\\\1|.){-})\1/
syn region Comment start="//" skip="\\$" end="$"
syn region Comment start="/\*" end="\*/"
syn match Todo "\v\s{-}\/\/\s{-}(TODO|NOTE|FIXME)\:.{-}$"
" highlight only catch in try-catch, not obj.catch()
syn match Exception /\v[^\.]\_s*\zscatch/

" detect jsx region
syntax region jsxRegion
      \ start=+\%(\%(\_[([,?:=+\-*/>{}]\|<\s\+\|&&\|||\|=>\|\<return\|\<default\|\<await\|\<yield\)\_s*\)\@<=<\_s*\%(>\|\z(\%(script\|\s*\<T\>\)\@!\<[_$A-Za-z][-:._$A-Za-z0-9]*\>\)\%(\_s*\%([-+*)\]}&|?,]\|/\%([/*]\|\_s*>\)\@!\)\)\@!\)+
      \ end=++
      \ contains=jsxElement

" <tag id="sample">
" ~~~~~~~~~~~~~~~~~
" and self close tag
" <tag id="sample"   />
" ~~~~~~~~~~~~~~~~~~~
syntax region jsxTag
      \ start=+<+
      \ matchgroup=jsxOpenPunct
      \ end=+>+
      \ matchgroup=NONE
      \ end=+\%(/\_s*>\)\@=+
      \ contained
      \ contains=jsxOpenTag,jsxAttrib,jsxExpressionBlock,jsxSpreadOperator,jsComment,@javascriptComments,javaScriptLineComment,javaScriptComment,typescriptLineComment,typescriptComment
      \ keepend
      \ extend
      \ skipwhite
      \ skipempty
      \ nextgroup=jsxCloseString

" <tag></tag>
" ~~~~~~~~~~~
" and fragment
" <></>
" ~~~~~
" and self close tag
" <tag />
" ~~~~~~~
syntax region jsxElement
      \ start=+<\_s*\%(>\|\${\|\z(\<[-:._$A-Za-z0-9]\+\>\)\)+
      \ end=+/\_s*>+
      \ end=+<\_s*/\_s*\z1\_s*>+
      \ contains=jsxElement,jsxTag,jsxExpressionBlock,jsxComment,jsxCloseTag,@Spell
      \ keepend
      \ extend
      \ contained
      \ fold

" <tag key={this.props.key}>
" ~~~~
" and fragment start tag
" <>
" ~~
exe 'syntax region jsxOpenTag
      \ matchgroup=jsxOpenPunct
      \ start=+<+
      \ end=+>+
      \ matchgroup=NONE
      \ end=+\>+
      \ contained
      \ contains=jsxTagName
      \ nextgroup=jsxAttrib
      \ skipwhite
      \ skipempty
      \ transparent'


" <tag key={this.props.key}>
"          ~~~~~~~~~~~~~~~~
syntax region jsxExpressionBlock
      \ matchgroup=jsxBraces
      \ start=+{+
      \ end=+}+
      \ contained
      \ extend
      \ contains=@jsExpression,jsSpreadExpression,@javascriptExpression,javascriptSpreadOp,@javaScriptEmbededExpr,@typescriptExpression,typescriptObjectSpread,jsComment,@javascriptComments,javaScriptLineComment,javaScriptComment,typescriptLineComment,typescriptComment

" <foo.bar>
"     ~
syntax match jsxDot +\.+ contained

" <foo:bar>
"     ~
syntax match jsxNamespace +:+ contained

" <tag id="sample">
"        ~
syntax match jsxEqual +=+ contained skipwhite skipempty nextgroup=jsxString,jsxExpressionBlock,jsxRegion

" <tag />
"      ~~
syntax match jsxCloseString +/\_s*>+ contained

" </tag>
" ~~~~~~
" and fragment close tag
" </>
" ~~~
syntax region jsxCloseTag
      \ matchgroup=jsxClosePunct
      \ start=+<\_s*/+
      \ end=+>+
      \ contained
      \ contains=jsxTagName

" <tag key={this.props.key}>
"      ~~~
syntax match jsxAttrib
      \ +\<[_$A-Za-z][-:_$A-Za-z0-9]*\>+
      \ contained
      \ nextgroup=jsxEqual
      \ skipwhite
      \ skipempty
      \ contains=jsxAttribKeyword,jsxNamespace

" <MyComponent ...>
"  ~~~~~~~~~~~
" NOT
" <someCamel ...>
"      ~~~~~
exe 'syntax match jsxComponentName
      \ +\<[_$]\?[A-Z][-_$A-Za-z0-9]*\>+
      \ contained
      \ transparent'

" <tag key={this.props.key}>
"  ~~~
exe 'syntax match jsxTagName
      \ +\<[-:._$A-Za-z0-9]\+\>+
      \ contained
      \ contains=jsxComponentName,jsxDot,jsxNamespace
      \ nextgroup=jsxAttrib
      \ skipempty
      \ skipwhite
      \ transparent'

" <tag id="sample">
"         ~~~~~~~~
" and
" <tag id='sample'>
"         ~~~~~~~~
syntax region jsxString start=+\z(["']\)+  skip=+\\\\\|\\\z1\|\\\n+  end=+\z1+ extend contained contains=@Spell

let s:tags = get(g:, 'vim_jsx_pretty_template_tags', ['html', 'jsx'])
let s:enable_tagged_jsx = !empty(s:tags)

" add support to JSX inside the tagged template string
" https://github.com/developit/htm
  exe 'syntax match jsxRegion +\%(' . join(s:tags, '\|') . '\)\%(\_s*`\)\@=+ contains=jsTemplateStringTag,jsTaggedTemplate,javascriptTagRef skipwhite skipempty nextgroup=jsxTaggedRegion'

  syntax region jsxTaggedRegion
        \ matchgroup=jsxBackticks
        \ start=+`+
        \ end=+`+
        \ extend
        \ contained
        \ contains=jsxElement,jsxExpressionBlock
        \ transparent

  syntax region jsxExpressionBlock
        \ matchgroup=jsxBraces
        \ start=+\${+
        \ end=+}+
        \ extend
        \ contained
        \ contains=@jsExpression,jsSpreadExpression,@javascriptExpression,javascriptSpreadOp,@javaScriptEmbededExpr,@typescriptExpression,typescriptObjectSpread

  syntax region jsxOpenTag
        \ matchgroup=jsxOpenPunct
        \ start=+<\%(\${\)\@=+
        \ matchgroup=NONE
        \ end=+}\@1<=+
        \ contained
        \ contains=jsxExpressionBlock
        \ skipwhite
        \ skipempty
        \ nextgroup=jsxAttrib,jsxSpreadOperator

  syntax keyword jsxAttribKeyword class contained

  syntax match jsxSpreadOperator +\.\.\.+ contained nextgroup=jsxExpressionBlock skipwhite

  syntax match jsxCloseTag +<//>+ contained

  syntax match jsxComment +<!--\_.\{-}-->+

" Highlight the tag name
highlight def link jsxTag Function
highlight def link jsxTagName Function
highlight def link jsxComponentName Function

highlight def link jsxAttrib Type
highlight def link jsxAttribKeyword jsxAttrib
highlight def link jsxString String
highlight def link jsxComment Comment

highlight def link jsxDot Operator
highlight def link jsxNamespace Operator
highlight def link jsxEqual Operator
highlight def link jsxSpreadOperator Operator
highlight def link jsxBraces Special

highlight def link jsxCloseString Function
highlight def link jsxOpenPunct jsxTag

highlight def link jsxPunct jsxCloseString
highlight def link jsxClosePunct jsxPunct
highlight def link jsxCloseTag jsxCloseString

let b:current_syntax = "javascript"

if main_syntax == 'javascript'
  unlet main_syntax
endif

let &cpo = s:cpo_save
unlet s:cpo_save

