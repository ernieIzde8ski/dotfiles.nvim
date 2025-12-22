require("settings.filetypes").setup()

if vim.g.host == "terminal" then
    require("settings.11-terminal")
elseif vim.g.host == "vscode" then
    require("settings.12-vscode")
end

-- confirm before destructive actions
vim.opt.confirm = true

-- folds
vim.opt.foldcolumn = "0"
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

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
    vim.opt.grepprg = "rg --vimgrep --pcre2"
end

-- smartcasing in search patterns
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- misc
vim.opt.scrolloff = 5
vim.opt.splitbelow = true
vim.g.editorconfig = true
