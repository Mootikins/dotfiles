-- Utilities for creating configurations
local util = require("formatter.util")

require("formatter").setup({
    filetype = {
        lua = {function() return {exe = "lua-format", stdin = true} end},
        fennel = {function() return {exe = "fnlfmt"} end}
    }
})
