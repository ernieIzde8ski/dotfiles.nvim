---@type MasonNullLsSettings
return {
    automatic_installation = false,
    ensure_installed = { "black", "isort", "clang-format", "stylua", "prettierd" },
    methods = {
        code_actions = true,
        formatting = true,
        completion = false,
        diagnostics = false,
        hover = false,
    },
    handlers = {},
}
