return function()
    local null_ls = require("null-ls")
    null_ls.setup({
        sources = {
            null_ls.builtins.code_actions.gitrebase,
            null_ls.builtins.formatting.prettierd,
            null_ls.builtins.formatting.black,
        },
    })
end
