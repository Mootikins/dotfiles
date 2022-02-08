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

map('n', '[b', '<Cmd>bprev<CR>', opts)
map('n', ']b', '<Cmd>bnext<CR>', opts)

map('n', '[t', '<Cmd>tabprev<CR>', opts)
map('n', ']t', '<Cmd>tabnext<CR>', opts)

map('n', '<C-w><C-h>', '<Cmd>vertical resize -5<CR>', opts)
map('n', '<C-w><C-l>', '<Cmd>vertical resize +5<CR>', opts)
map('n', '<C-w><C-j>', '<Cmd>resize -5<CR>', opts)
map('n', '<C-w><C-k>', '<Cmd>resize +5<CR>', opts)

map('n', '<C-w>s', '<Cmd>new<CR>', opts)
map('n', '<C-w>v', '<Cmd>vnew<CR>', opts)

map('n', 'Q', '@@', opts)

map('n', 'g<CR>', '<Cmd>nohl<CR>', opts)
