local set_keymap = require("helpers.set-keymap")

return {
    -- treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            ---@diagnostic disable-next-line: missing-fields
            require("nvim-treesitter.configs").setup({
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
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },

    -- netrw replacement
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1

            require("nvim-tree").setup({
                hijack_cursor = true,
                diagnostics = {
                    enable = true,
                },
                actions = {
                    open_file = {
                        quit_on_open = not vim.g.keep_tree_open,
                    },
                },
            })

            local api = require("nvim-tree.api")
            set_keymap({ "n", "v" }, "<F3>", api.tree.toggle)
        end,
    },

    {
        "antosha417/nvim-lsp-file-operations",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-tree.lua",
        },
        opts = {},
    },

    -- LSP display
    {
        "mrded/nvim-lsp-notify",
        dependencies = { "rcarriga/nvim-notify" },
        config = true,
    },

    {
        "felpafel/inlay-hint.nvim",
        config = true,
    },
}
