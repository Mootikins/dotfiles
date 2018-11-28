set list
set listchars=tab:\|\ 
hi NonText ctermfg=237
"
"Highlight columns 81 and 101 on lines with that many characters
call matchadd('ColorColumn', '\%81v', 100)
call matchadd('ColorColumn', '\%101v', 100)
