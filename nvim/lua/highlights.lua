function SetupHighlights()
    vim.cmd [[
    highlight DiffText guibg=#3333DD guifg=none
    highlight DiffAdd guibg=#006600 guifg=#FFFFFF
    highlight DiffDelete guibg=#BB0000 guifg=none
    highlight DiffChange guibg=#000088 guifg=none
    ]]
end

vim.cmd [[
augroup CustomHighlights
    autocmd!
    autocmd VimEnter * lua SetupHighlights()

    autocmd WinEnter * set cursorline
    autocmd WinLeave * set nocursorline
augroup END
]]
