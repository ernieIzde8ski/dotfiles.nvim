---@type MasonNullLsSettings
return {
    automatic_installation = false,
    ensure_installed = {
        -- formatters
        "isort",
        "ruff_format",
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
