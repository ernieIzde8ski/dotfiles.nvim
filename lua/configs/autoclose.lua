return {
    keys = {
        ["<"] = { close = true, escape = true, pair = "<>" },
        ["'"] = { close = false, escape = true, pair = "''" },
        ["|"] = {
            close = true,
            escape = true,
            pair = "||",
            enabled_filetypes = { "rust" },
        },
    },
    options = {
        disable_command_mode = true,
    },
}
