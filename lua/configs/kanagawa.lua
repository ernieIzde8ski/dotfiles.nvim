return function()
    if os.getenv("IS_WORK_MACHINE") == "true" then
        vim.o.background = "light"
    else
        vim.o.background = "dark"
    end

    vim.cmd.syntax("enable")
    vim.cmd.colorscheme("kanagawa")
end
