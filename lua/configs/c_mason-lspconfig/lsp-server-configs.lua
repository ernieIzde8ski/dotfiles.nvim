local success = pcall(require, "mason-lspconfig")

if success == false then
    error("Cannot build LSP configs before mason-lspconfig is available!")
end

local fs = require("helpers.fs")

---All servers that use default capabilities
---@type { [string]:  lspconfig.Config }
return {
    biome = {
        root_dir = function(filename)
            local util = require("lspconfig.util")
            ---@diagnostic disable-next-line: redundant-return-value
            return util.root_pattern("biome.json", "biome.jsonc")(filename)
                or fs:find_root(".git", filename)
                or fs:find_root("package.json", filename)
                or fs:find_root("node_modules", filename)
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
        root_dir = function(filename)
            local util = require("lspconfig.util")
            ---@diagnostic disable-next-line: redundant-return-value
            return util.root_pattern(".typst_root", ".typst-root")(filename)
                or fs:find_root(".git", filename)
                or fs:find_root("Cargo.toml", filename)
        end,
    },
}
