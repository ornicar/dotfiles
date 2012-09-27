setlocal omnifunc=necoghc#omnifunc
autocmd BufWritePost *.hs GhcModCheckAndLintAsync
compiler cabal
