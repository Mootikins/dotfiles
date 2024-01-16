require("formatter").setup({
    filetype = {
        fennel = { function() return { exe = "fnlfmt" } end },
        lua = { function() return { exe = "stylua --search-parent-directories" } end },
        python = { function() return { exe = "black" } end },
        sh = { function() return { exe = "shfmt", stdin = true } end },
        zsh = { function() return { exe = "shfmt", stdin = true } end },
    }
})
