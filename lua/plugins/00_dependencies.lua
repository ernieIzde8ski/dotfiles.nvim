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
        "rcarriga/nvim-notify",
        lazy = true,
        config = function()
            local notify = require("notify")

            notify.setup({
                -- todo: switch to wrapped-default when merged:
                -- https://github.com/rcarriga/nvim-notify/pull/286
                render = "wrapped-compact",

                max_width = function()
                    return math.min(80, math.floor(vim.o.columns * 0.5))
                end,
            })

            vim.notify = notify
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
