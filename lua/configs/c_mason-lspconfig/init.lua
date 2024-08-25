local mlc_opts = {
    package_names = {
        "basedpyright",
        "gopls",
        "hls",
        "jsonls",
        "lua_ls",
        "rust_analyzer",
        "tinymist",
        "tsserver",
    },
}
return function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")
    local server_configs = require("configs.c_mason-lspconfig.lsp-server-configs")
    local mlc_deferred = require("configs.c_mason-lspconfig.deferred-install")

    mason_lspconfig.setup({})

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

    mlc_deferred.setup(mlc_opts)
end
