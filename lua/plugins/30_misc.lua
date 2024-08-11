local set_keymap = require("helpers.set-keymap")
return {
    { "tpope/vim-eunuch" },
    { "tpope/vim-surround" },

    {
        "m4xshen/autoclose.nvim",
        opts = {
            keys = {
                ["<"] = { close = true, escape = true, pair = "<>" },
                ["'"] = { close = false, escape = true, pair = "''" },
                ["|"] = {
                    close = true,
                    escape = true,
                    pair = "||",
                    enabled_filetypes = { "rust" },
                },
            },
            options = {
                disable_command_mode = true,
            },
        },
    },

    {
        "IogaMaster/neocord",
        ---@diagnostic disable-next-line: unused-local
        cond = function(args)
            if vim.g.discord_available == nil then
                vim.g.discord_available = os.execute(
                    "test -S $XDG_RUNTIME_DIR/discord-ipc-0"
                ) == 0
            end

            return vim.g.discord_available
        end,

        opts = {
            logo_tooltip = "You pissant little gnome.",
            show_time = true,
            global_timer = true,
        },
    },

    {
        "m4xshen/hardtime.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
        },
        opts = {},
    },

    {
        "karb94/neoscroll.nvim",
        config = function()
            local neoscroll = require("neoscroll")
            local modes = { "n", "v", "x" }
            local keymaps = {
                ["<C-u>"] = function()
                    neoscroll.ctrl_u({ duration = 50 })
                end,
                ["<C-d>"] = function()
                    neoscroll.ctrl_d({ duration = 50 })
                end,
                ["<C-b>"] = function()
                    neoscroll.ctrl_b({ duration = 100 })
                end,
                ["<C-f>"] = function()
                    neoscroll.ctrl_f({ duration = 100 })
                end,
                ["<C-y>"] = function()
                    neoscroll.scroll(-0.1, { move_cursor = false, duration = 25 })
                end,
                ["<C-e>"] = function()
                    neoscroll.scroll(0.1, { move_cursor = false, duration = 25 })
                end,
                ["zt"] = function()
                    neoscroll.zt({ half_win_duration = 50 })
                end,
                ["zz"] = function()
                    neoscroll.zz({ half_win_duration = 50 })
                end,
                ["zb"] = function()
                    neoscroll.zb({ half_win_duration = 50 })
                end,
            }

            neoscroll.setup({ mappings = { easing = "sine" } })
            for key, func in pairs(keymaps) do
                set_keymap(modes, key, func)
            end
        end,
    },
}
