-- Bubbles config for lualine
-- Author: lokesh-krishna
-- MIT license, see LICENSE for more details.

-- stylua: ignore
local colors = {
    -- black  = '#080808',
    -- red    = '#ff5189',
    -- blue   = '#80a0ff',
    -- cyan   = '#79dac8',
    -- white  = '#c6c6c6',
    -- magenta = '#d183e8',
    -- grey   = '#303030',
    black   = '#1E1D2F',
    red     = '#F28FAD',
    green   = '#ABE9B3',
    yellow  = '#FAE3B0',
    blue    = '#96CDFB',
    magenta = '#F5C2E7',
    cyan    = '#89DCEB',
    white   = '#D9E0EE',
    grey    = '#3E3C4E',
    light_grey = '#685B72',
}

local bubbles_theme = {
    normal = {
        a = { fg = colors.black, bg = colors.blue },
        b = { fg = colors.black, bg = colors.green },
        c = { fg = colors.white, bg = colors.grey },
    },

    insert = { a = { fg = colors.black, bg = colors.blue } },
    visual = { a = { fg = colors.black, bg = colors.cyan } },
    replace = { a = { fg = colors.black, bg = colors.red } },

    inactive = {
        a = { fg = colors.white, bg = colors.light_grey },
        b = { fg = colors.white, bg = colors.light_grey },
        c = { fg = colors.white, bg = colors.grey },
    },
}

require('lualine').setup {
    options = {
        theme = bubbles_theme,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
    },
    sections = {
        lualine_a = {
            { 'mode', separator = { left = '', right = '' }, right_padding = 2 },
        },
        lualine_b = { 'branch' },
        lualine_c = { 'filename' },
        lualine_x = { 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = {
            { 'location', separator = { left = '', right = '' }, left_padding = 2 },
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
    tabline = {},
    extensions = {},
}
