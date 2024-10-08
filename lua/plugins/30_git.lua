local set_keymap = require("helpers.set-keymap")

---@type LazyPluginSpec[]
return {
    {
        "tpope/vim-fugitive",
        config = function()
            set_keymap("n", "<Leader>ga", ":Git add -N -- %")
            set_keymap("n", "<Leader>gA", ":Git add -- %")
            set_keymap("n", "<Leader>gcc", ":Git commit")
            set_keymap("n", "<Leader>gcp", ":Git commit --patch")
        end,
    },

    {
        "tpope/vim-rhubarb",
        dependencies = { "tpope/vim-fugitive" },
        config = function()
            set_keymap({ "n", "v" }, "<Leader>gb", ":GBrowse")
        end,
    },

    {
        "lewis6991/gitsigns.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local gitsigns = require("gitsigns")

            gitsigns.setup({
                attach_to_untracked = true,
                current_line_blame = true,
                current_line_blame_opts = {
                    delay = 0,
                    virt_text_pos = "right_align",
                },
                numhl = true,
            })

            set_keymap("n", "<Leader>gs", gitsigns.stage_hunk)
            set_keymap("n", "<Leader>gS", gitsigns.stage_buffer)
            set_keymap("n", "<Leader>gP", gitsigns.preview_hunk_inline)
            set_keymap({ "n", "v" }, "<Leader>gp", gitsigns.preview_hunk)
            set_keymap({ "n", "v" }, "<Leader>gw", gitsigns.toggle_word_diff)
            set_keymap({ "n", "v" }, "[g", function()
                gitsigns.nav_hunk("prev")
            end)
            set_keymap({ "n", "v" }, "]g", function()
                gitsigns.nav_hunk("next")
            end)
        end,
    },
}
