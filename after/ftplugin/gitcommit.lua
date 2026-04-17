local open_windows = vim.api.nvim_list_wins()

if #open_windows == 1 then
    vim.api.nvim_command("Git diff --staged")
end
