return {
    {
        "rebelot/kanagawa.nvim",
        priority = 1000,
        lazy = false,
        config = function()
            if os.getenv("IS_WORK_MACHINE") == "true" then
                vim.o.background = "light"
            else
                vim.o.background = "dark"
            end

            vim.cmd.syntax("enable")
            vim.cmd.colorscheme("kanagawa")
        end,
    },

    {
        "nvim-lua/plenary.nvim",
    },

    {
        "rcarriga/nvim-notify",
        config = function()
            vim.notify = require("notify")
        end,
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
