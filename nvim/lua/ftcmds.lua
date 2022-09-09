api = vim.api

local ft_extensions = api.nvim_create_augroup("FiletypeExtensions", { clear = false })

api.nvim_create_autocmd({ "BufEnter", "BufNew" }, {
	pattern = "*.lst",
	command = "set filetype=dosini",
})
