return function()
    if os.getenv("DARK_MODE") == "true" then
        vim.o.background = "dark"
    else
        vim.o.background = "light"
    end

    -- I think this is legacy tbh
    if vim.fn.has("termguicolors") then
        vim.opt.termguicolors = true
    end
    vim.cmd.syntax("enable")

    -- make LSP/diagnostic displays have box-drawing character borders
    local float_border = { border = "double" }

    vim.lsp.handlers["textDocument/hover"] =
        vim.lsp.with(vim.lsp.handlers.hover, float_border)

    vim.lsp.handlers["textDocument/signatureHelp"] =
        vim.lsp.with(vim.lsp.handlers.signature_help, float_border)

    vim.diagnostic.config({
        float = float_border,
    })

    require("kanagawa").setup({
        transparent = true,
        colors = {
            theme = {
                all = {
                    ui = {
                        float = { bg = "none", bg_border = "none" },
                        bg_gutter = "none",
                    },
                },
            },
        },
        overrides = function(colors)
            local theme = colors.theme
            return {
                -- use kanagawa colors in these popup windows
                -- NormalFloat = { bg = "none" },
                -- FloatBorder = { bg = "none" },
                -- FloatTitle = { bg = "none" },
                NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
                LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            }
        end,
    })

    vim.cmd.colorscheme("kanagawa")
end
