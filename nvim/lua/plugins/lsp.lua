-- Change gutter symbols
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
		local buf_map = vim.keymap.set

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf, noremap = true, silent = true }
		buf_map("n", "gd", '<cmd>lua require("lspsaga.provider").lsp_finder()<CR>', opts)
		buf_map("n", "gD", '<cmd>lua require("lspsaga.provider").preview_definition()<CR>', opts)
		buf_map("n", "K", '<cmd>lua require("lspsaga.hover").render_hover_doc()<CR>', opts)
		buf_map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
		buf_map("n", "<C-S-k>", '<cmd>lua require("lspsaga.signaturehelp").signature_help()<CR>', opts)
		buf_map("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
		buf_map("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
		buf_map("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
		buf_map("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
		buf_map("n", "<leader>rn", '<cmd>lua require("lspsaga.rename").rename()<CR>', opts)
		buf_map("n", "<leader>ca", '<cmd>lua require("lspsaga.codeaction").code_action()<CR>', opts)
		buf_map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	end,
})

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"bashls",
		"clangd",
		"dockerls",
		"efm",
		"lua_ls",
		"pyright",
		"rust_analyzer",
		"tsserver",
		"vimls",
	},
})
require("mason-lspconfig").setup_handlers({
	-- The first entry (without a key) will be the default handler
	-- and will be called for each installed server that doesn't have
	-- a dedicated handler.
	function(server_name) -- default handler (optional)
		require("lspconfig")[server_name].setup({})
	end,
	-- Next, you can provide a dedicated handler for specific servers.
	-- For example, a handler override for the `rust_analyzer`:
	-- ["rust_analyzer"] = function()
	-- 	require("rust-tools").setup({})
	-- end,
})

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local map_opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap

map("n", "<leader>e", "<cmd>Lspsaga show_line_diagnostics<CR>", map_opts)
map("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", map_opts)
map("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", map_opts)
map("n", "<leader>q", "<cmd>TroubleToggle document_diagnostics<CR>", map_opts)
map("n", "<leader>Q", "<cmd>TroubleToggle workspace_diagnostics<CR>", map_opts)

local cmp_kinds = {
	Text = "  ",
	Method = "  ",
	Function = "  ",
	Constructor = "  ",
	Field = "  ",
	Variable = "  ",
	Class = "  ",
	Interface = "  ",
	Module = "  ",
	Property = "  ",
	Unit = "  ",
	Value = "  ",
	Enum = "  ",
	Keyword = "  ",
	Snippet = "  ",
	Color = "  ",
	File = "  ",
	Reference = "  ",
	Folder = "  ",
	EnumMember = "  ",
	Constant = "  ",
	Struct = "  ",
	Event = "  ",
	Operator = "  ",
	TypeParameter = "  ",
}

local cmp = require("cmp")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
cmp.setup({
	snippet = {
		expand = function(args)
			require("snippy").expand_snippet(args.body) -- For `snippy` users.
		end,
	},
	mapping = {
		["<A-k>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<A-j>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-y>"] = cmp.config.disable,
		["<CR>"] = cmp.mapping.confirm({ select = false }),
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, { "i", "s" }),
	},
	sources = cmp.config.sources({ { name = "nvim_lsp" }, { name = "snippy" } }, {
		{ name = "path" },
		{ name = "omni" },
		{ name = "buffer" },
	}),
	formatting = {
		format = function(_, vim_item)
			vim_item.kind = (cmp_kinds[vim_item.kind] or "") .. vim_item.kind
			return vim_item
		end,
	},
})

require("snippy").setup({
	mappings = {
		is = { ["<C-l>"] = "expand", ["<C-j>"] = "next", ["<C-k>"] = "previous" },
		nx = { ["<leader>x"] = "cut_text" },
	},
})
