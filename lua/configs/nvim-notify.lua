return function()
    local notify = require("notify")

    -- lua_ls is convinced this is the mason package named `notify`, for some reason
    ---@diagnostic disable-next-line: undefined-field
    notify.setup({
        -- todo: switch to wrapped-default when merged:
        -- https://github.com/rcarriga/nvim-notify/pull/286
        render = "wrapped-compact",

        max_width = function()
            return math.min(80, math.floor(vim.o.columns * 0.5))
        end,
    })

    vim.notify = notify
end
