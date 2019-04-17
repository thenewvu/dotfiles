setlocal noexpandtab

augroup MAKE
    au!
    au BufWritePre *.mk :Tabularize /\\$
    au BufWritePre makefile :Tabularize /\\$
augroup END
