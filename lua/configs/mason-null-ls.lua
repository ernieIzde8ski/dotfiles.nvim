---@type MasonNullLsSettings
return {
    automatic_installation = true,
    ensure_installed = { "prettierd", "black" },
    methods = {
        code_actions = true,
        formatting = true,
        completion = false,
        diagnostics = false,
        hover = false,
    },
}
