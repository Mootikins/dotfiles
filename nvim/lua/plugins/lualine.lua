-- Bubbles config for lualine
-- Author: lokesh-krishna
-- MIT license, see LICENSE for more details.

-- stylua: ignore
local colors = {
	black      = '#1E1E2E',
	red        = '#F28FAD',
	green      = '#ABE9B3',
	yellow     = '#FAE3B0',
	blue       = '#96CDFB',
	magenta    = '#F5C2E7',
	cyan       = '#89DCEB',
	white      = '#D9E0EE',
	light_grey = '#504D71',
	grey       = '#302D41',
}

local bubbles_theme = {
	normal = {
		a = { fg = colors.black, bg = colors.blue, gui = 'bold' },
		b = { fg = colors.black, bg = colors.green },
		c = { fg = colors.white, bg = colors.grey },
	},

	insert = { a = { fg = colors.black, bg = colors.red, gui = 'bold' } },
	visual = { a = { fg = colors.black, bg = colors.magenta, gui = 'bold' } },
	replace = { a = { fg = colors.black, bg = colors.red, gui = 'bold' } },

	inactive = {
		a = { fg = colors.white, bg = colors.light_grey },
		b = { fg = colors.white, bg = colors.light_grey },
		c = { fg = colors.white, bg = colors.grey },
	},
}

require('lualine').setup {
	options = {
		theme = bubbles_theme,
		section_separators = { left = '', right = '' },
		component_separators = { left = '', right = '' },
	},
	sections = {
		lualine_a = {
			{ 'mode', separator = { left = '', right = '' }, right_padding = 2 },
		},
		lualine_b = {
			{ 'diff', colored = false, source = vim.b.gitsigns_status, separator = '' },
			'branch',
		},
		lualine_c = {
			{ 'filename', path = 1 }
		},
		lualine_x = { 'filetype' },
		lualine_y = {
			{ 'fileformat', separator = { left = '', right = '' }, right_padding = 1 },
			{ 'encoding', right_padding = 1 },
		},
		lualine_z = {
			{ 'location', separator = { left = '', right = '' }, padding = 1 },
		},
	},
	inactive_sections = {
		lualine_a = {
			{ 'filename', separator = { left = '', right = '' }, right_padding = 2 },
		},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {
			{ 'location', separator = { left = '', right = '' }, left_padding = 2 },
		},
	},
	tabline = {
		lualine_a = {
			{ 'buffers', separator = { left = '', right = '' }, left_padding = 2 },
		},
		lualine_y = {
			{ 'tabs',
			separator = { left = '', right = '' }, left_padding = 2 },
		},
	},
	extensions = {},
}
