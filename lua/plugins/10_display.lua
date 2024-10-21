---@type LazyPluginSpec[]
return {
    -- syntax highlighting
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        main = "nvim-treesitter.configs",
        opts = require("configs.nvim-treesitter"),
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
    },

    {
        "antosha417/nvim-lsp-file-operations",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-tree.lua",
        },
        opts = {},
    },

    {
        "felpafel/inlay-hint.nvim",
        config = true,
    },
}
