---@type LazyPluginSpec[]
return {
    { "tpope/vim-eunuch" },
    { "tpope/vim-surround" },

    {
        "m4xshen/autoclose.nvim",
        opts = require("configs.autoclose"),
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
        "karb94/neoscroll.nvim",
        config = require("configs.neoscroll"),
    },
}
