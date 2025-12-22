---@type LazyPluginSpec[]
return {
    {
        "rebelot/kanagawa.nvim",
        priority = 1000,
        lazy = false,
        config = require("configs.c_kanagawa"),
        cond = vim.g.host == "terminal",
    },

    {
        "j-hui/fidget.nvim",
        tag = "v1.4.5",
        opts = {
            notification = { override_vim_notify = true },
        },
        lazy = false,
        priority = 100,
        cond = vim.g.host == "terminal",
    },

    {
        "klen/nvim-config-local",
        -- Should load first, but is not explicitly listed in case of VSCode
        -- dependencies = { "j-hui/fidget.nvim" },
        opts = { lookup_parents = true },
    },

    {
        "nvim-tree/nvim-web-devicons",
        opts = {},
    },
}
