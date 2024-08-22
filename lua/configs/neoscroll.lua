local set_keymap = require("helpers.set-keymap")

return function()
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
end
