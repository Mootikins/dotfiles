-- Change gutter symbols
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local map_opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap

-- TODO: Change bindings to lspsaga
map('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', map_opts)
map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', map_opts)
map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', map_opts)
map('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', map_opts)

local cmp_kinds = {
	Text = '  ',
	Method = '  ',
	Function = '  ',
	Constructor = '  ',
	Field = '  ',
	Variable = '  ',
	Class = '  ',
	Interface = '  ',
	Module = '  ',
	Property = '  ',
	Unit = '  ',
	Value = '  ',
	Enum = '  ',
	Keyword = '  ',
	Snippet = '  ',
	Color = '  ',
	File = '  ',
	Reference = '  ',
	Folder = '  ',
	EnumMember = '  ',
	Constant = '  ',
	Struct = '  ',
	Event = '  ',
	Operator = '  ',
	TypeParameter = '  ',
}

local cmp = require('cmp')
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))
cmp.setup({
	snippet = {
		expand = function(args)
			require('snippy').expand_snippet(args.body) -- For `snippy` users.
		end
	},
	mapping = {
		['<A-k>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
		['<A-j>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
		['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
		['<C-y>'] = cmp.config.disable,
		['<CR>'] = cmp.mapping.confirm({ select = false }),
		['<C-e>'] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, { 'i', 's', }),
	},
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'snippy' },
	}, {
		{ name = 'path' },
		{ name = 'omni' },
		{ name = 'buffer' },
	}),
	formatting = {
		format = function(_, vim_item)
			vim_item.kind = (cmp_kinds[vim_item.kind] or '') .. vim_item.kind
			return vim_item
		end,
	},
})

require('snippy').setup({
	mappings = {
		is = {
			['<C-l>'] = 'expand',
			['<C-j>'] = 'next',
			['<C-k>'] = 'previous',
		},
		nx = {
			['<leader>x'] = 'cut_text',
		}
	}
})

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_client, bufnr)
	local buf_map = vim.api.nvim_buf_set_keymap
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_map(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', map_opts)
	buf_map(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', map_opts)
	buf_map(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', map_opts)
	buf_map(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', map_opts)
	buf_map(bufnr, 'n', '<C-S-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', map_opts)
	buf_map(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', map_opts)
	buf_map(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', map_opts)
	buf_map(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', map_opts)
	buf_map(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', map_opts)
	buf_map(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', map_opts)
	buf_map(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', map_opts)
	buf_map(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', map_opts)
	buf_map(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', map_opts)

	vim.cmd [[
		augroup LSPOnAttach
			autocmd!
			autocmd CursorHold,CursorHoldI *.rs :lua require('lsp_extensions').inlay_hints({ only_current_line = true, enabled = {"TypeHint", "ChainingHint", "ParameterHint"} })
		augroup end
	]]
end

local lsp_installer = require("nvim-lsp-installer")

-- Register a handler that will be called for each installed server when it's ready (i.e. when installation is finished
-- or if the server is already installed).
local servers = {
	'pyright',
	'rust_analyzer',
	'tsserver',
	'dockerls',
	'sumneko_lua',
	'vimls',
}

local lsp_installer_servers = require('nvim-lsp-installer.servers')
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
for _, lsp in pairs(servers) do
	local server_available, server = lsp_installer_servers.get_server(lsp)
	if server_available then
		server:on_ready(function ()
			local opts = { on_attach = on_attach }
			-- (optional) Customize the options passed to the server
			-- if server.name == "tsserver" then
			--     opts.root_dir = function() ... end
			-- end

			-- This setup() function will take the provided server configuration and decorate it with the necessary properties
			-- before passing it onwards to lspconfig.
			-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
			server:setup(opts)
		end)
		if not server:is_installed() then
			server:install()
		end
	end
end
