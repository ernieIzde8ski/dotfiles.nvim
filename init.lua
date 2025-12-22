if vim.g.vscode then
    --- @type "vscode" | "terminal"
    vim.g.host = "vscode"
else
    vim.g.host = "terminal"
end

require("settings")
require("lazy-config")
require("keymaps")
