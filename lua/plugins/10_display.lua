---@type LazyPluginSpec[]
return {
    -- syntax highlighting
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
        opts = {
            ensure_installed = {
                "diff",
                "gitignore",
                "gitcommit",
                "gotmpl",
                "haskell",
                "ini",
                "javascript",
                "json",
                "jsonc",
                "lua",
                "markdown",
                "python",
                "rust",
                "toml",
                "typescript",
                "typst",
                "vimdoc",
                "yaml",
            },
        },
    },

    {
        "https://gitlab.com/HiPhish/rainbow-delimiters.nvim.git",
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = require("configs.indent-blankline"),
    },

    -- netrw replacement
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = require("configs.nvim-tree"),
        cond = vim.g.host == "terminal",
    },

    {
        "antosha417/nvim-lsp-file-operations",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-tree.lua",
        },
        opts = {},
        cond = vim.g.host == "terminal",
    },

    {
        "felpafel/inlay-hint.nvim",
        config = true,
        cond = vim.g.host == "terminal",
    },
}
