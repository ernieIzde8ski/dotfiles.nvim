local set_keymap = require("helpers.set-keymap")

vim.api.nvim_create_autocmd({ "TermOpen" }, {
    callback = function()
        set_keymap({ "n", "v" }, "q", vim.cmd.bd, true)
    end,
})

-- local notify = require("notify")
local close_buffer = vim.cmd.bd
local update_buffer = vim.cmd.update
local write_all_buffers = vim.cmd.wall

local function close_other_buffers()
    write_all_buffers()

    local current_bufnr = vim.api.nvim_get_current_buf()
    local active_bufnrs = vim.tbl_filter(function(bufnr)
        return bufnr ~= current_bufnr and vim.api.nvim_buf_is_valid(bufnr)
        -- and vim.api.nvim_get_option_value("buflisted", { buf = bufnr })
    end, vim.api.nvim_list_bufs())

    for _, bufnr in ipairs(active_bufnrs) do
        if bufnr ~= current_bufnr then
            close_buffer(bufnr)
        end
    end

    vim.notify("Closed " .. #active_bufnrs .. " buffers")
end
set_keymap("n", "<Leader>bD", close_other_buffers)

-- close other buffers
set_keymap("n", "<Leader>bd", "mc<cmd>wall | %bd | e# | bd#<cr>`c")

-- FOOT PEDAL.
set_keymap({ "n", "v" }, "<F13>", vim.cmd.bprev)
set_keymap("n", "<F14>", "<Leader>")
set_keymap({ "n", "v" }, "<F15>", vim.cmd.bnext)

-- other keymaps
set_keymap("n", "dD", "0D")
set_keymap("n", "<C-W>d", vim.diagnostic.open_float)
set_keymap("n", "<Esc>", vim.cmd.nohlsearch)
set_keymap("n", "<F5>", update_buffer)
set_keymap({ "n", "v" }, "gm", "gM")
set_keymap({ "n", "v" }, "gM", "gm")
set_keymap({ "n", "v" }, "/", "/\\v")

---@type { [string]: string }
vim.g.shell_providers = {
    python = "!python3",
    javascript = "!node",
    typescript = "!npx ts-node",
    lua = "so",
}

local function execute_current_file()
    update_buffer()

    local vim_command

    -- checking for a shebang
    if string.match(vim.fn.getline(1), "^#!") then
        local fp = vim.fn.expand("%")
        if vim.fn.getfperm(fp):sub(3, 3) == "x" then
            -- execute full path to file
            vim_command = "!%:p"
        else
            vim.notify(
                "'" .. fp .. "' contains a shebang, but is not executable",
                vim.log.levels.ERROR
            )
            return
        end
    elseif vim.g.shell_providers[vim.bo.filetype] ~= nil then
        vim_command = vim.g.shell_providers[vim.bo.filetype] .. " %"
    else
        vim.notify(
            "File is not executable and does not have an associated shell provider. Set a shell provider for this filetype in `vim.g.shell_providers`.",
            vim.log.levels.ERROR
        )
        return
    end

    vim.notify(
        "Executing file with arguments: '" .. vim_command .. "'",
        vim.log.levels.DEBUG
    )

    vim.cmd(vim_command)
end

set_keymap("n", "<F6>", execute_current_file) -- execute current file

---jump with `key` to snippet in `direction`, if available
---@param key string
---@param direction integer
---@return fun(): string
local function jump_with(key, direction)
    local command = "<cmd>lua vim.snippet.jump(" .. direction .. ")<cr>"
    local function resp()
        if vim.snippet.active({ direction = direction }) then
            return command
        else
            return key
        end
    end
    return resp
end

vim.keymap.set({ "i", "s" }, "<Tab>", jump_with("<Tab>", 1), { expr = true })
vim.keymap.set({ "i", "s" }, "<S-Tab>", jump_with("<S-Tab>", -1), { expr = true })
