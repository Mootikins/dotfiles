return {
  {
    "alexghergh/nvim-tmux-navigation",
    event = "VeryLazy",
    opts = function()
      require("nvim-tmux-navigation").setup({
        disable_when_zoomed = true,
      })
    end,
  },
  "godlygeek/tabular",
  "tpope/vim-eunuch",
  "tpope/vim-fugitive",
  "tpope/vim-obsession",
  "tpope/vim-repeat",
  "tpope/vim-sleuth",
  "kergoth/vim-bitbake",
}
