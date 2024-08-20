return function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")
    local server_configs = require("configs.mason-lspconfig.lsp-server-configs")

    mason_lspconfig.setup({
        ensure_installed = {
            "gopls",
            "jsonls",
            "lua_ls",
            "basedpyright",
            "rust_analyzer",
            "tsserver",
        },
    })

    mason_lspconfig.setup_handlers({
        function(server_name)
            local config = server_configs[server_name]
            if config == nil then
                lspconfig[server_name].setup({ capabilities = capabilities })
            else
                config.capabilities = capabilities
                lspconfig[server_name].setup(config)
            end
        end,

        -- listed separately so `capabilities` are not inherited
        ["rust_analyzer"] = function()
            lspconfig.rust_analyzer.setup(server_configs["rust_analyzer"])
        end,
    })
end
