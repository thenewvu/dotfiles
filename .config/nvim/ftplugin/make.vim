setlocal noexpandtab

augroup MAKE
    au!
    au BufWritePre *.mk :%EasyAlign*/\\$/
    au BufWritePre makefile :%EasyAlign*/\\$/
augroup END
