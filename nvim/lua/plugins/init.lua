local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.cmd [[ packadd packer.nvim ]]

function packer_uses(use)
	use { 'wbthomason/packer.nvim' }
	use { 'neovim/nvim-lspconfig',
		wants = { 'nvim-lsp-installer' },
		config = function()
			require('plugins.lsp')
		end
	}
	use { 'williamboman/nvim-lsp-installer' }
	use { 'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		config = function()
			require('plugins.treesitter')
		end
	}
	use { 'hrsh7th/cmp-nvim-lsp' }
	use { 'hrsh7th/cmp-buffer' }
	use { 'hrsh7th/cmp-path' }
	use { 'hrsh7th/nvim-cmp' }
	use { 'dcampos/nvim-snippy' }
	use { 'dcampos/cmp-snippy' }
	use { 'honza/vim-snippets' }
	use { 'numToStr/Comment.nvim',
		config = function()
			require('plugins.comment')
		end
	}
	use { 'ibhagwan/fzf-lua',
		requires = { 'kyazdani42/nvim-web-devicons' },
		config = function()
			require('plugins.fzf-lua')
		end
	}
	use { 'norcalli/nvim-colorizer.lua',
		config = function()
			require('colorizer').setup({
				'*';
				'!packer';
			}) end
	}
	use { 'lukas-reineke/indent-blankline.nvim',
		config = function()
			require('indent_blankline').setup({
				show_current_context = true,
				space_char_blankline = ' ',
			}) end
	}
	use { 'christoomey/vim-tmux-navigator' }
	use { 'machakann/vim-sandwich' }
	use { 'windwp/nvim-autopairs',
		config = function()
			require('nvim-autopairs').setup({
				disable_in_visualblock = false,
			})
		end
	}
	use { 'mhartington/formatter.nvim',
		config = function()
			require('formatter').setup({
				filetype = {
					lua = { function()
						return {
							exe = "stylua",
							args = { "-" },
							stdin = true,
						}
					end }
				}
			})
		end
	}
	use { 'wincent/terminus' }
	use { 'mbbill/undotree' }
	use { 'wellle/targets.vim' }
	use { 'rcarriga/nvim-notify' }
	use { 'tpope/vim-eunuch' }
	use { 'tpope/vim-fugitive' }
	use { 'tpope/vim-obsession' }
	use { 'tpope/vim-repeat' }
	use { 'tpope/vim-sleuth' }
	use { 'catppuccin/nvim',
		as = 'catppuccin',
		config = function()
			require('plugins/catppuccin')
		end
	}

	if packer_bootstrap then require('packer').sync() end
end

return require('packer').startup(packer_uses)
