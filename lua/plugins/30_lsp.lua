---@type LazyPluginSpec[]
return {
    require("configs.p_mason"),

    {
        "nvimtools/none-ls.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "jay-babu/mason-null-ls.nvim",
        },
        config = require("configs.none-ls"),
    },

    {
        "jay-babu/mason-null-ls.nvim",
        dependencies = { "williamboman/mason.nvim" },
        opts = require("configs.o_mason-null-ls"),
    },

    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "j-hui/fidget.nvim",
            "williamboman/mason.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = require("configs.c_mason-lspconfig"),
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "j-hui/fidget.nvim",
            "felpafel/inlay-hint.nvim",
        },
        config = require("configs.nvim-lspconfig"),
    },
}
