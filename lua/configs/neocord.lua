return {
    cond = function()
        if vim.g.discord_available == nil then
            vim.g.discord_available = os.execute("test -S $XDG_RUNTIME_DIR/discord-ipc-0")
                == 0
        end

        return vim.g.discord_available
    end,

    opts = {
        logo_tooltip = "You pissant little gnome.",
        show_time = true,
        global_timer = true,
    },
}
