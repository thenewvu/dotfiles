syn region	cDefine		start="^\s*\zs\(%:\|#\)\s*\(define\|undef\)\>" skip="\\$" end="$" keepend contains=ALLBUT,@cPreProcGroup,@Spell fold

syn match CustomDelimiters                 /[(){},;]/ display
syn match CustomOperators  /[\[\]\<\>\+\-\*=!\^&:\.]/ display

hi   link CustomDelimiters                  Delimiter
hi   link CustomOperators                    Operator
