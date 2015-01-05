" Note: « Vim automatically wraps the contents of ftdetect/*.vim files in autocommand groups for you,
"       so you don't need to worry about it. » Steve Losh.
au BufRead,BufNewFile *.anubis setfiletype anubis
