local success = pcall(require, "mason-lspconfig")

if success == false then
    error("Cannot build LSP configs before mason-lspconfig is available!")
end

---All servers that use default capabilities
---@type { [string]:  lspconfig.Config }
return {
    biome = {
        root_dir = function(fname)
            local util = require("lspconfig.util")
            local fs = require("helpers.fs")
            ---@diagnostic disable-next-line: redundant-return-value
            return util.root_pattern("biome.json", "biome.jsonc")(fname)
                or fs:find_root(".git", fname)
                or fs:find_root("package.json", fname)
                or fs:find_root("node_modules", fname)
        end,
    },

    hls = {
        filetypes = { "haskell", "lhaskell", "cabal" },
    },

    lua_ls = {
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
    },

    rust_analyzer = {
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
    },

    tinymist = {
        settings = {
            formatterMode = "typstyle",
            exportPdf = "onDocumentHasTitle",
        },
    },
}
