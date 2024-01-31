local fn = vim.fn
local opt = vim.opt

vim.o.guifont = "SpaceMono Nerd Font:h6:#h-normal"

opt.laststatus = 3
opt.cmdheight = 1
opt.mouse = "a"
opt.swapfile = false
opt.compatible = false
opt.number = true
opt.relativenumber = true
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.ignorecase = true
opt.splitbelow = true
opt.splitright = true
opt.wrap = false
opt.signcolumn = "auto:2"
opt.showmode = false
opt.virtualedit = "block"
opt.completeopt = "menu,menuone,noselect"
opt.updatetime = 500
opt.formatoptions = "tcrqn2lj"
opt.textwidth = 100
opt.scrolloff = 0

opt.list = true
opt.listchars = "nbsp:·,trail:·,tab:▏ "

opt.title = true
opt.titlelen = 35

opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4

opt.smartindent = true

opt.hidden = false
opt.synmaxcol = 240

opt.undofile = true
opt.undodir = fn.stdpath("data") .. "/undo"

opt.wrap = true
opt.showbreak = "-> "

opt.foldenable = false
opt.foldlevelstart = 0
opt.modeline = true

opt.diffopt:append("iwhite")
opt.diffopt:append("indent-heuristic")
opt.diffopt:append("algorithm:patience,vertical")
opt.diffopt:append("algorithm:histogram")

opt.termguicolors = true
opt.cursorline = true
