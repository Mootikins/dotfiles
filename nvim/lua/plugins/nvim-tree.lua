require('nvim-tree').setup({
	view = { width = 45 }
})

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('n', '<leader>t', '<Cmd>NvimTreeFindFileToggle<CR>', opts)
