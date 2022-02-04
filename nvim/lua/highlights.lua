vim.cmd [[
augroup BgHighlight
    autocmd!
    autocmd WinEnter * set cul
    autocmd WinLeave * set nocul
augroup END
]] 

vim.cmd [[
highlight DiffText guibg=#2222CC guifg=none
highlight DiffAdd guibg=#009900 guifg=none
highlight DiffDelete guibg=#DD0000 guifg=none
highlight DiffChange guibg=#000044 guifg=none
]]
