require("settings.filetypes").setup()

-- make sure that the UI fills up the *entire* terminal window.
-- purportedly this can be done in my wezterm config, but it's easy to
-- do it here instead

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

-- confirm before destructive actions
vim.opt.confirm = true

-- folds
vim.opt.foldcolumn = "0"
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- display tabs & trailing whitespace
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- line display
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

-- 4-space-width tabs
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.shiftround = true
vim.opt.smartindent = true

-- ripgrep
if vim.fn.executable("rg") ~= 0 then
    vim.opt.grepprg = "rg --vimgrep"
end

-- smartcasing in search patterns
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- misc
vim.opt.scrolloff = 5
vim.opt.splitbelow = true
vim.g.editorconfig = true
