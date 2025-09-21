api = vim.api

local ft_extensions = api.nvim_create_augroup("FiletypeExtensions", { clear = false })

api.nvim_create_autocmd({ "BufEnter", "BufNew" }, {
  pattern = "*.lst",
  command = "set filetype=dosini",
})

api.nvim_create_autocmd({ "BufEnter", "BufNew" }, {
  pattern = "*.conf.sample",
  command = "set filetype=bitbake",
})

api.nvim_create_autocmd({ "BufEnter", "BufNew" }, {
  pattern = "*.conf",
  command = "set filetype=bitbake",
})

api.nvim_create_autocmd({ "BufEnter", "BufNew" }, {
  pattern = "*tmux.conf",
  command = "set filetype=tmux",
})
