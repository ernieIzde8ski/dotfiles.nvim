-- setting filetypes & a filetype-based autocommand

local set = require("helpers.set")
local set_keymap = require("helpers.set-keymap")

----- FILETYPES -----

---@type vim.filetype.add.filetypes
local filetype_additions = {
    extension = {
        zsh = "sh",
    },
    filename = {
        [".chezmoiignore"] = "gotmpl",
        [".chezmoiremove"] = "gotmpl",
        [".jsbeautifyrc"] = "json",
        [".zshrc"] = "sh",
        [".zshenv"] = "sh",
        ["template"] = "bash", -- void-packages
    },
    pattern = {
        [".*.tmpl"] = "gotmpl",
        [".*dot_zshrc"] = "sh", -- chezmoi dotfile format
        [".*dot_zshenv"] = "sh",
    },
}

----- FILETYPE AUTOCMD -----

local autocmd_filetypes = {
    two_space_indent = set.new({
        "fstab",
        "gitcommit",
        "haskell",
        "html",
        "markdown",
        "pug",
        "srt",
        "typst",
    }),
    quick_close = set.new({
        "help",
        "sh",
        "qf",
    }),
}

local autocmd_opts = {
    ---@type string[]
    pattern = set.as_array(
        set.union({ autocmd_filetypes.two_space_indent, autocmd_filetypes.quick_close })
    ),

    ---Copied directly from the docs lmao
    ---@class autocmd_callback_event
    ---@field id number autocommand id
    ---@field group? string autocommand group id, if any
    ---@field match string expanded value of <amatch>
    ---@field buf number expanded value of <abuf>
    ---@field file string expanded value of <afile>
    ---@field data any arbitrary data passed from `nvim_exec_autocmds()`

    ---@type fun(ev:autocmd_callback_event)
    callback = function(ev)
        if autocmd_filetypes.two_space_indent[ev.match] then
            vim.opt_local.shiftwidth = 2
            vim.opt_local.tabstop = 2
        end

        if autocmd_filetypes.quick_close[ev.match] then
            set_keymap({ "n", "v" }, "q", vim.cmd.bd, true)
        end
    end,
}

return {
    setup = function()
        vim.filetype.add(filetype_additions)
        vim.api.nvim_create_autocmd({ "FileType" }, autocmd_opts)
    end,
}
