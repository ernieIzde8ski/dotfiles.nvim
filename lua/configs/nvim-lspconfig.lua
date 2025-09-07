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

    local lspconfig = vim.lsp.config
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    lspconfig("*", {
        root_markers = { ".git" },
        capabilities = capabilities,
    })

    lspconfig("basedpyright", {
        root_markers = { { "pyproject.toml" }, ".git" },
    })

    lspconfig("biome", {
        root_markers = {
            { "biome.json", "biome.jsonc" },
            { "package.json", "node_modules" },
            ".git",
        },
    })

    lspconfig("hls", { filetypes = { "haskell", "lhaskell", "cabal" } })

    lspconfig("lua_ls", {
        ---@diagnostic disable-next-line: unused-local
        on_init = function(client, initialize_result)
            client.config.settings.Lua =
                vim.tbl_deep_extend("force", client.config.settings.Lua, {
                    workspace = {
                        checkThirdParty = false,
                        library = vim.api.nvim_get_runtime_file("", true),
                    },
                })
        end,
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim", "require" },
                },
                runtime = { version = "LuaJIT" },
            },
        },
    })

    lspconfig("stylua", {
        root_markers = { ".stylua.toml", ".git" },
    })

    lspconfig("rust_analyzer", {
        settings = {
            ["rust-analyzer"] = {
                imports = {
                    granularity = { group = "module" },
                    prefix = "self",
                },
                cargo = {
                    buildScripts = { enable = true },
                },
                procMacro = { enable = true },
            },
        },
    })
end
