---@type LazyPluginSpec[]
return {
    { "tpope/vim-eunuch" },
    { "tpope/vim-surround" },

    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = require("configs.c_nvim_autopairs"),
    },

    {
        "IogaMaster/neocord",
        cond = require("configs.neocord").cond,
        opts = require("configs.neocord").opts,
    },

    {
        "m4xshen/hardtime.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
        },
        opts = {},
    },

    {
        "chomosuke/typst-preview.nvim",
        ft = "typst",
        opts = {}, -- lazy.nvim will implicitly calls `setup {}`
    },

    require("configs.p_neoscroll"),
}
