---@type LazyPluginSpec[]
return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "mrded/nvim-lsp-notify",
            "felpafel/inlay-hint.nvim",
        },
        config = require("configs.nvim-lspconfig"),
    },

    {
        "williamboman/mason.nvim",
        opts = require("configs.mason"),
    },

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
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = require("configs.mason-lspconfig"),
    },
}
