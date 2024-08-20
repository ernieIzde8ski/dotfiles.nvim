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
            ---@diagnostic disable-next-line: redundant-return-value
            return util.root_pattern("biome.json", "biome.jsonc")(fname)
                or util.find_git_ancestor(fname)
                or util.find_package_json_ancestor(fname)
                or util.find_node_modules_ancestor(fname)
        end,
    },
    hls = {
        filetypes = { "haskell", "lhaskell", "cabal" },
    },
    lua_ls = {
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim", "require" },
                },
                runtime = { version = "LuaJIT" },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                },
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
    typst_lsp = {
        settings = { exportPdf = "never" },
    },
}
