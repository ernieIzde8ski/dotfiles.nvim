return {
    {
        "Julian/lean.nvim",
        event = { "BufReadPre *.lean", "BufNewFile *.lean" },

        dependencies = {
            "neovim/nvim-lspconfig",
            "nvim-lua/plenary.nvim",
            "hrsh7th/nvim-cmp",

        },

        ---@type lean.Config
        opts = { -- see below for full configuration options
            mappings = true,
        },
    },
}
