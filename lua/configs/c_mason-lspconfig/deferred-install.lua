---@alias PackageNameToFiletypes {[string]: string[]}

---@type notify.Options
---@diagnostic disable-next-line: missing-fields
local _notify_opts = { title = "mason.nvim (config)" }
local _levels = vim.log.levels
local logger = {
    ---Call `vim.notify` with level DEBUG.
    ---@param message string Message to pass into `vim.notify`.
    debug = function(message)
        vim.notify(message, _levels.DEBUG, _notify_opts)
    end,
    ---Call `vim.notify` with level INFO.
    ---@param message string Message to pass into `vim.notify`.
    info = function(message)
        vim.notify(message, _levels.INFO, _notify_opts)
    end,
    ---Call `vim.notify` with level WARN.
    ---@param message string Message to pass into `vim.notify`.
    warn = function(message)
        vim.notify(message, _levels.WARN, _notify_opts)
    end,
    ---Call `vim.notify` with level ERROR.
    ---@param message string Message to pass into `vim.notify`.
    error = function(message)
        vim.notify(message, _levels.ERROR, _notify_opts)
    end,
}

---Filters packages for packages known by `mason-registry` , `mason-lspconfig`, and `lspconfig`.
---@param package_names string[] Package names. Names known by either `mason-registry` or `lspconfig` are allowed.
---@return PackageNameToFiletypes valid_packages Packages that correspond to LSP servers, are not yet installed, and are associated with the mapped filetypes.
local function filter_packages(package_names)
    local registry = require("mason-registry")
    local mlc_mappings = require("mason-lspconfig").get_mappings()
    local lspconfig = require("lspconfig")

    local lspc_to_mason = mlc_mappings.lspconfig_to_mason
    local mason_to_lspc = mlc_mappings.mason_to_lspconfig

    ---packages that exist and are not yet installed
    ---@type PackageNameToFiletypes
    local valid_packages = {}
    ---packages that are named but do not exist
    ---@type string[]
    local unknown_package_names = {}
    ---packages that are named but have no associated filetypes
    ---@type string[]
    local unknown_filetypes = {}

    for _, package_name in ipairs(package_names) do
        local lspconfig_name
        local mason_name

        if lspc_to_mason[package_name] ~= nil then
            lspconfig_name = package_name
            mason_name = lspc_to_mason[package_name]
        elseif mason_to_lspc[package_name] ~= nil then
            lspconfig_name = mason_to_lspc[package_name]
            mason_name = package_name
        else
            table.insert(unknown_package_names, package_name)
            goto continue
        end

        if registry.is_installed(mason_name) then
            logger.debug("already installed: " .. mason_name)
            goto continue
        end

        local server = lspconfig[lspconfig_name]
        local filetypes = server.document_config.default_config.filetypes

        if filetypes == nil or #filetypes == 0 then
            table.insert(unknown_filetypes, package_name)
            goto continue
        end

        valid_packages[mason_name] = filetypes

        ::continue::
    end

    local error_message = ""

    if #unknown_package_names > 0 then
        error_message = "Unknown package name(s): "
            .. table.concat(unknown_package_names, ", ")
            .. "\n"
    end

    if #unknown_filetypes > 0 then
        error_message = error_message
            .. "LSP server(s) without associated filetypes: "
            .. table.concat(unknown_filetypes, ", ")
    end

    if error_message ~= "" then
        logger.warn(error_message)
    end

    return valid_packages
end

---@type string
local augroup_hook_name = "MasonRegistryFiletypeHook"

---@alias StringSet { [string]: true }

---Creates the autocommand that actually installs servers
---@param filetype_to_package_names { [string]: StringSet }
---@return fun(ev: autocmd_callback_event)
local function create_autocmd_callback(filetype_to_package_names)
    -- TODO: maybe refactor? we could use the `mason-registry` api and install plugins less synchronously

    local registry = require("mason-registry")

    ---@type fun(ev:autocmd_callback_event)
    local function inner(ev)
        if filetype_to_package_names[ev.match] == nil then
            return
        end

        local lsps = vim.tbl_keys(filetype_to_package_names[ev.match])

        vim.cmd("MasonInstall " .. table.concat(lsps, " "))
        filetype_to_package_names[ev.match] = nil

        local remaining_filetypes = vim.tbl_count(filetype_to_package_names)

        if remaining_filetypes == 0 then
            vim.api.nvim_clear_autocmds({ group = augroup_hook_name })
            logger.debug("Unregistered " .. augroup_hook_name .. " augroup")
        end
    end
    return inner
end

---@param package_name_to_fts PackageNameToFiletypes
local function create_autocmd(package_name_to_fts)
    -- TODO: refactor, we pass around a struct from `filter_packages` just to
    -- reinterpret it in this function

    ---Inversion of `package_name_to_fts`: a mapping of filetype
    ---to LSP packages.
    ---@type { [string]: StringSet }
    local ft_to_package_names = {}

    for package_name, filetypes in pairs(package_name_to_fts) do
        for _, filetype in ipairs(filetypes) do
            if ft_to_package_names[filetype] == nil then
                ft_to_package_names[filetype] = {}
            end
            ft_to_package_names[filetype][package_name] = true
        end
    end

    ---@type string[]
    local filetypes = {}

    for filetype, _ in pairs(ft_to_package_names) do
        table.insert(filetypes, filetype)
    end

    vim.api.nvim_create_augroup(augroup_hook_name, { clear = true })
    vim.api.nvim_create_autocmd({ "FileType" }, {
        -- group = augroup_hook_name,
        pattern = filetypes,
        callback = create_autocmd_callback(ft_to_package_names),
    })

    logger.debug("Registered autocommand under augroup '" .. augroup_hook_name .. "'")
end

return {
    ---@class deferred-install-opts
    ---@field package_names string[]

    ---Sets up deferred installation for any `mason-lspconfig`-supported package.
    ---@param opts deferred-install-opts
    setup = function(opts)
        if opts == nil or opts.package_names == nil then
            logger.error("Parameters missing `opts.package_name`")
            return
        end

        local valid_package_names = filter_packages(opts.package_names)

        if vim.tbl_keys(valid_package_names) == 0 then
            logger.debug("No new packages to install")
            return
        end

        create_autocmd(valid_package_names)
    end,
}
