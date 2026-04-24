return function()
    local is_dark_mode = os.getenv("DARK_MODE")
    if is_dark_mode == nil or is_dark_mode == "true" then
        vim.o.background = "dark"
    elseif is_dark_mode == "false" then
        vim.o.background = "light"
    end

    -- I think this is legacy tbh
    if vim.fn.has("termguicolors") then
        vim.opt.termguicolors = true
    end
    vim.cmd.syntax("enable")

    require("kanagawa").setup()
    vim.cmd.colorscheme("kanagawa")
end
