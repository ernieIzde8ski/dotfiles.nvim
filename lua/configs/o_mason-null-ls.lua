---@type MasonNullLsSettings
return {
    automatic_installation = false,
    ensure_installed = {
        -- formatters
        "black",
        "isort",
        "clang-format",
        "prettierd",
        "stylua",
        "yamlfmt",
        -- linters
        "gitlint",
    },
    methods = {
        code_actions = true,
        formatting = true,
        completion = true,
        diagnostics = true,
        hover = true,
    },
    handlers = {},
}
