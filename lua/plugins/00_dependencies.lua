---@type LazyPluginSpec[]
return {
    {
        "rebelot/kanagawa.nvim",
        priority = 1000,
        lazy = false,
        config = require("configs.kanagawa"),
    },

    {
        "rcarriga/nvim-notify",
        lazy = true,
        config = require("configs.nvim-notify"),
    },

    {
        "klen/nvim-config-local",
        dependencies = { "rcarriga/nvim-notify" },
        opts = { lookup_parents = true },
    },

    {
        "nvim-tree/nvim-web-devicons",
        opts = {},
    },
}
