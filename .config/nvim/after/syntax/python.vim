syn region pythonFold start="^\z(\s*\)\(class\|def\)\s" skip="\(\s*\n\)\+\z1\s\+\(\S\|\%$\)" end="\(\s*\n\)\+\s*\(\S\|\%$\)"me=s-1 transparent fold

syn match pythonOperator "[\]\[]"
syn match pythonStatement ":"

syn match Delimiter "[().,]" display

syn match pythonFunction "\<\k\+\ze(" display
