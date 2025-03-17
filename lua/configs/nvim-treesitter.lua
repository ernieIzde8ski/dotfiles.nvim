---@diagnostic disable-next-line: missing-fields
return {
    auto_install = true,
    ensure_installed = {
        "diff",
        "gitignore",
        "gitcommit",
        "gotmpl",
        "haskell",
        "ini",
        "javascript",
        "json",
        "jsonc",
        "lua",
        "markdown",
        "python",
        "rust",
        "toml",
        "typescript",
        "typst",
        "vimdoc",
        "yaml",
    },
    highlight = {
        enable = true,
        disable = { "typst" },
    },
    indent = { enable = true },
}
