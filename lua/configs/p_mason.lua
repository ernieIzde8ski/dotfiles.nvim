---@type LazyPluginSpec
return {
    "williamboman/mason.nvim",
    ---@type MasonSettings
    opts = {
        ui = {
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗",
            },
        },
    },
}
