---@type LazyPluginSpec[]
return {
    require("configs.p_mason"),

    {
        "nvimtools/none-ls.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = require("configs.none-ls"),
    },

    {
        "jay-babu/mason-null-ls.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "nvimtools/none-ls.nvim",
        },
        opts = require("configs.mason-null-ls"),
    },

    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "rcarriga/nvim-notify",
            "williamboman/mason.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = require("configs.c_mason-lspconfig"),
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "mrded/nvim-lsp-notify",
            "felpafel/inlay-hint.nvim",
        },
        config = require("configs.nvim-lspconfig"),
    },
}
