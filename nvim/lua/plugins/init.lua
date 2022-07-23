local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' ..
                   install_path)
end

vim.cmd [[ packadd packer.nvim ]]

local function packer_uses(use)
    use {'wbthomason/packer.nvim'}
    use {
        'neovim/nvim-lspconfig',
        wants = {'nvim-lsp-installer'},
        config = function() require('plugins.lsp') end
    }
    use {'williamboman/nvim-lsp-installer'}
    use {'nvim-lua/lsp_extensions.nvim'}
    use {'tami5/lspsaga.nvim'}
    use {
        'folke/trouble.nvim',
        requires = {'kyazdani42/nvim-web-devicons'},
        config = function()
            require('trouble').setup({
                padding = false,
                auto_preview = true,
                auto_fold = true
            })
        end
    }
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function() require('plugins.treesitter') end
    }
    use {'hrsh7th/cmp-nvim-lsp'}
    use {'hrsh7th/cmp-buffer'}
    use {'hrsh7th/cmp-path'}
    use {'hrsh7th/cmp-omni'}
    use {'hrsh7th/nvim-cmp'}
    use {'dcampos/nvim-snippy'}
    use {'dcampos/cmp-snippy'}
    use {'honza/vim-snippets'}
    use {
        'numToStr/Comment.nvim',
        config = function() require('plugins.comment') end
    }
    use {
        'ibhagwan/fzf-lua',
        requires = {'kyazdani42/nvim-web-devicons', opt = true},
        config = function() require('plugins.fzf-lua') end
    }
    use {'sbdchd/neoformat'}
    use {
        'norcalli/nvim-colorizer.lua',
        config = function() require('colorizer').setup({'*', '!packer'}) end
    }
    use {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require('indent_blankline').setup({
                show_current_context = true,
                space_char_blankline = ' '
            })
        end
    }
    use {'christoomey/vim-tmux-navigator'}
    use {
        'windwp/nvim-autopairs',
        config = function() require('nvim-autopairs').setup() end
    }
    use {
        'ggandor/leap.nvim',
        config = function() require('leap').set_default_keymaps() end
    }
    use {
        'lewis6991/gitsigns.nvim',
        requires = {'nvim-lua/plenary.nvim'},
        tag = 'release',
        config = function() require('plugins.gitsigns') end
    }
    use {
        'folke/which-key.nvim',
        config = function() require('which-key').setup() end
    }
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {'kyazdani42/nvim-web-devicons', opt = true},
        config = function() require('plugins.nvim-tree') end
    }
    use {
        'ziontee113/color-picker.nvim',
        config = function() require('color-picker') end
    }
    use {'godlygeek/tabular'}
    use {'wincent/terminus'}
    use {'mbbill/undotree'}
    use {'wellle/targets.vim'}
    use {'rcarriga/nvim-notify'}
    use {'tpope/vim-eunuch'}
    use {'tpope/vim-fugitive'}
    use {'tpope/vim-obsession'}
    use {'tpope/vim-repeat'}
    use {'tpope/vim-sleuth'}
    use {
        "kylechui/nvim-surround",
        config = function() require("nvim-surround").setup() end
    }
    use {'kergoth/vim-bitbake'}
    use {
        'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true},
        config = function() require('plugins.lualine') end
    }
    use {
        'folke/tokyonight.nvim',
        config = function() require('plugins.tokyonight') end
    }

    if packer_bootstrap then require('packer').sync() end
end

return require('packer').startup(packer_uses)
