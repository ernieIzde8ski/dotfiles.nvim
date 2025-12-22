local augroup_ui = vim.api.nvim_create_augroup("fullsize_terminal_ui", {})

vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme" }, {
    group = augroup_ui,
    callback = function()
        local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
        if not normal.bg then
            return
        end
        io.write(string.format("\027]11;#%06x\027\\", normal.bg))
    end,
})

vim.api.nvim_create_autocmd("UILeave", {
    group = augroup_ui,
    callback = function()
        io.write("\027]111\027\\")
    end,
})

-- display tabs & trailing whitespace
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
