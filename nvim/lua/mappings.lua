local opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap

map('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

map('i', 'kj', '<ESC>', opts)

map('n', 'za', 'zA', opts)
map('n', 'zl', 'zo', opts)
map('n', 'zh', 'zc', opts)
map('n', 'zL', 'zO', opts)
map('n', 'zH', 'zC', opts)

map('n', ';', ':', { noremap = true })
map('n', ':', ';', { noremap = true })
map('v', ';', ':', { noremap = true })
map('v', ':', ';', { noremap = true })
map('x', ';', ':', { noremap = true })
map('x', ':', ';', { noremap = true })

map('n', 'H', '^', opts)
map('n', 'L', 'g_', opts)
map('v', 'H', '^', opts)
map('v', 'L', 'g_', opts)
map('x', 'H', '^', opts)
map('x', 'L', 'g_', opts)
map('o', 'H', '^', opts)
map('o', 'L', 'g_', opts)
