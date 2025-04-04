local set_keymap = require("helpers.set-keymap")

local group_name = "dotfiles_LSPAttach"

---@type { [string]: string }
local lsp_keymaps = {
    ["<Leader>a"] = "code_action",
    ["<Leader>f"] = "format",
    ["<Leader>gt"] = "typehierarchy",
    ["<F2>"] = "rename",
    ["K"] = "hover",
    ["g<C-d>"] = "declaration",
    ["gD"] = "type_definition",
    ["gd"] = "definition",
    ["gr"] = "references",
}

---@param args { buf: number, data: any }
---@return nil
local function callback(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    for key, buf_op in pairs(lsp_keymaps) do
        set_keymap("n", key, vim.lsp.buf[buf_op], bufnr)
    end

    if client ~= nil and client.supports_method("textDocument/inlayHint") then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        set_keymap("n", "<Leader>i", function()
            vim.lsp.inlay_hint.enable(
                not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }),
                { bufnr = bufnr }
            )
        end, bufnr)
    end
end

return function()
    local opts = { callback = callback, group = group_name }
    vim.api.nvim_create_augroup(group_name, {})
    vim.api.nvim_create_autocmd("LspAttach", opts)
end
