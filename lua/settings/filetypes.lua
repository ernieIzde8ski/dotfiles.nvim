-- setting filetypes & a filetype-based autocommand

local set = require("helpers.set")
local set_keymap = require("helpers.set-keymap")

----- FILETYPES -----

---Finds the index of the next result before the pattern.
---If not available, returns the end of the line.
---@param line string
---@param pattern string
---@return number
local function find_next_or_end(line, pattern)
    local res = line:find(pattern)
    if res then
        return res - 1
    else
        return #line
    end
end

---Returns the name of the executable at the top of the file, if available.
---@param line string
---@return string | nil
local function parse_shebang_from_line(line)
    if line == nil or line:sub(1, 2) ~= "#!" or #line < 4 then
        return
    end

    line = vim.trim(line)
    local first_word_end = find_next_or_end(line, " ")
    local first_word = line:sub(3, first_word_end)
    first_word = first_word:reverse()
    first_word = first_word:sub(1, find_next_or_end(first_word, "/")):reverse()

    if #first_word == 0 then
        return nil
    elseif first_word ~= "env" then
        return first_word
    end

    local second_word_start = first_word_end + 2
    if second_word_start > #line then
        return nil
    end

    local next_word = vim.trim(line:sub(second_word_start))
    local next_word_end = find_next_or_end(next_word, " ")
    -- fix "#!/usr/bin/env -S ..."
    if vim.trim(next_word:sub(1, next_word_end)) == "-S" then
        next_word = vim.trim(next_word:sub(next_word_end + 1))
    end
    next_word = vim.trim(next_word:sub(1, find_next_or_end(next_word, " ")))

    if #next_word then
        return next_word
    end
end

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
        [".*"] = function(_, bufnr)
            if vim.fn.executable("rg") == 0 then
                return
            end

            local first_line = vim.api.nvim_buf_get_lines(bufnr, 0, 1, true)[1]
            local shebang = parse_shebang_from_line(first_line)
            if shebang == nil then
                return
            end
            vim.notify("shebang found: " .. shebang)
            if shebang == "xonsh" then
                return shebang
            end
        end,
        [".*.tmpl"] = "gotmpl",
        [".*dot_(zshrc|zshenv)"] = "sh", -- chezmoi dotfile format
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
