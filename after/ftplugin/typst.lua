local set_keymap = require("helpers.set-keymap")

if vim.g.typst_opts == nil then
    ---@class typst-opts
    ---@field filetype "pdf" | "png" | "svg" | nil
    ---@field target_dir string | nil
    ---@field open_on_save boolean | nil
    vim.g.typst_opts = {}
end

local function compile_file()
    ---@type string[]
    local arguments = { "%" }
    local opts = vim.g.typst_opts

    local target = "%:r." .. (opts.filetype or "pdf")
    if opts.target_dir ~= nil then
        target = opts.target_dir .. target
    end
    table.insert(arguments, target)

    local command = "!typst c"
    for _, argument in ipairs(arguments) do
        command = command .. " '" .. string.gsub(argument, "'", "\\'") .. "'"
    end
    vim.cmd(command)

    if opts.open_on_save then
        vim.cmd("!xdg-open " .. target)
    end
end

set_keymap({ "n", "v" }, "<F6>", compile_file, true)
vim.opt_local.conceallevel = 2
