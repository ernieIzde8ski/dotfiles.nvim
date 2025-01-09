local set_keymap = require("helpers.set-keymap")

return function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    require("nvim-tree").setup({
        hijack_cursor = true,
        diagnostics = {
            enable = true,
        },
        actions = {
            open_file = {
                quit_on_open = not vim.g.keep_tree_open,
            },
        },
    })

    local api = require("nvim-tree.api")
    set_keymap({ "n", "v" }, "<F3>", api.tree.toggle)
end
