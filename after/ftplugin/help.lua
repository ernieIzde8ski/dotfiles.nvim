local set_keymap = require("helpers.set-keymap")
set_keymap({ "n", "v" }, "q", vim.cmd.bd, true)
