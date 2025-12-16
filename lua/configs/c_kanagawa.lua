return function()
    local is_dark_mode = os.getenv("DARK_MODE")
    if is_dark_mode == nil or is_dark_mode == "true" then
        vim.o.background = "dark"
    elseif is_dark_mode == "false" then
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
        -- transparent = true,
    })

    vim.cmd.colorscheme("kanagawa")
end
