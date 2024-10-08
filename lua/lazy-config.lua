-- Bootstrap lazy.nvim
local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

---@diagnostic disable-next-line: undefined-field
if not vim.uv.fs_stat(lazy_path) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        lazyrepo,
        lazy_path,
    })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end

vim.opt.rtp:prepend(lazy_path)

vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

local function is_weekend()
    local wday = os.date("*t").wday
    return wday == 1 or wday == 7
end

require("lazy").setup({
    spec = { import = "plugins" },
    checker = {
        -- I'm only allowed to edit my neovim configs on the weekend
        enabled = is_weekend(),
    },
    change_detection = {
        notify = false,
    },
})
