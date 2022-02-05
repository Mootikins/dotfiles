vim.cmd [[
augroup BgHighlight
    autocmd!
    autocmd BufEnter * setlocal cursorline
    autocmd BufLeave * setlocal nocursorline
    autocmd FocusGained * setlocal cursorline
    autocmd FocusLost * setlocal nocursorline
augroup END
]] 

function SetupHighlights()
    vim.cmd [[
    highlight DiffText guibg=#3333DD guifg=none
    highlight DiffAdd guibg=#006600 guifg=#FFFFFF
    highlight DiffDelete guibg=#BB0000 guifg=none
    highlight DiffChange guibg=#000088 guifg=none
    ]]
end

vim.cmd [[
augroup BgHighlight
    autocmd!
    autocmd VimEnter * lua SetupHighlights()
augroup END
]] 
