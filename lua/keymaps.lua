local set_keymap = require("helpers.set-keymap")

vim.api.nvim_create_autocmd({ "TermOpen" }, {
    callback = function()
        set_keymap({ "n", "v" }, "q", vim.cmd.bd, true)
    end,
})

-- close other buffers
set_keymap("n", "<Leader>bd", "mc<cmd>wall | %bd | e# | bd#<cr>`c")

-- FOOT PEDAL.
set_keymap({ "n", "v" }, "<F13>", vim.cmd.bprev)
set_keymap("n", "<F14>", "<Leader>")
set_keymap({ "n", "v" }, "<F15>", vim.cmd.bnext)

-- other keymaps
set_keymap("n", "<C-B>", "Bi")
set_keymap("i", "<C-B>", "<C-O>B")
set_keymap("n", "<C-W>d", vim.diagnostic.open_float)
set_keymap("n", "<Esc>", vim.cmd.nohlsearch)
set_keymap("n", "<F5>", vim.cmd.update)
set_keymap("n", "<F6>", "<cmd>!%:p<cr>") -- execute current file
set_keymap({ "n", "v" }, "gm", "gM")
set_keymap({ "n", "v" }, "gM", "gm")
