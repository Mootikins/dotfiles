local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

vim.cmd([[ packadd packer.nvim ]])

return require("packer").startup(function(use)
	use { "wbthomason/packer.nvim" }
	use { "williamboman/mason.nvim" }
	use { "williamboman/mason-lspconfig.nvim" }
	use { "neovim/nvim-lspconfig",
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup()
			require("plugins/lsp")
		end,
	}
	use { "nvim-lua/lsp_extensions.nvim" }
	use { "tami5/lspsaga.nvim" }
	use {
		"folke/trouble.nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("trouble").setup { padding = false, auto_preview = true, auto_fold = true }
		end,
	}
	use {
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = function()
			require("plugins.treesitter")
		end,
	}
	use {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-omni",
		"hrsh7th/nvim-cmp",
		"dcampos/nvim-snippy",
		"dcampos/cmp-snippy",
		"honza/vim-snippets",
	}
	use {
		"numToStr/Comment.nvim",
		config = function()
			require("plugins.comment")
		end,
	}
	use {
		"ibhagwan/fzf-lua",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = function()
			require("plugins.fzf-lua")
		end,
	}
	use {
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup { "*", "!packer" }
		end,
	}
	use {
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("indent_blankline").setup { show_current_context = true, space_char_blankline = " " }
		end,
	}
	use { "christoomey/vim-tmux-navigator" }
	use {
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup()
		end,
	}
	use {
		"mhartington/formatter.nvim",
		config = function()
			require("plugins.formatter-nvim")
		end,
	}
	use {
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		tag = "release",
		config = function()
			require("plugins.gitsigns")
		end,
	}
	use {
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup()
		end,
	}
	use {
		"kyazdani42/nvim-tree.lua",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = function()
			require("plugins.nvim-tree")
		end,
	}
	use {
		"ziontee113/color-picker.nvim",
		config = function()
			require("color-picker")
		end,
	}
	use { "godlygeek/tabular" }
	use { "wincent/terminus" }
	use { "mbbill/undotree" }
	use { "wellle/targets.vim" }
	use { "rcarriga/nvim-notify" }
	use { "tpope/vim-eunuch" }
	use { "tpope/vim-fugitive" }
	use { "tpope/vim-obsession" }
	use { "tpope/vim-repeat" }
	use { "tpope/vim-sleuth" }
	use {
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup { surrounds = { [" "] = { add = { " ", " " } } } }
		end,
	}
	use { "kergoth/vim-bitbake" }
	use {
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = function()
			require("plugins.lualine")
		end,
	}
	use {
		"folke/tokyonight.nvim",
		config = function()
			require("plugins.tokyonight")
		end,
	}

	if packer_bootstrap then
		require("packer").sync()
	end
end)
