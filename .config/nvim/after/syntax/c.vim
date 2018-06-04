syn match CustomDelimiters                 /[(){},;]/ display
syn match CustomOperators  /[\[\]\<\>\+\-\*=!\^&:\.]/ display

hi   link CustomDelimiters                  Delimiter
hi   link CustomOperators                    Operator
