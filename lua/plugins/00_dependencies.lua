---@type LazyPluginSpec[]
return {
    {
        "rebelot/kanagawa.nvim",
        priority = 1000,
        lazy = false,
        config = require("configs.c_kanagawa"),
    },

    {
        "j-hui/fidget.nvim",
        tag = "v1.4.5",
        opts = {
            notification = { override_vim_notify = true },
        },
    },

    {
        "klen/nvim-config-local",
        dependencies = { "j-hui/fidget.nvim" },
        opts = { lookup_parents = true },
    },

    {
        "nvim-tree/nvim-web-devicons",
        opts = {},
    },
}
