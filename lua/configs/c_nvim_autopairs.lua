---Helper function. Always returns false.
---@return false
local function new_false()
    return false
end

---@param plugin LazyPlugin
---@param opts table
return function(plugin, opts)
    require(plugin.name).setup(opts)
    local npairs = require("nvim-autopairs")
    local Rule = require("nvim-autopairs.rule")
    local cond = require("nvim-autopairs.conds")

    npairs.setup(opts)

    for _, punct in pairs({ ",", ";", ":" }) do
        npairs.add_rules({
            Rule("", punct)
                :with_move(function(m_opts)
                    return m_opts.char == punct
                end)
                :with_pair(new_false)
                :with_del(new_false)
                :with_cr(new_false)
                :use_key(punct),
        })
    end

    npairs.add_rule(Rule("<", ">"):with_pair(
        -- regex will make it so that it will auto-pair on
        -- `a<` but not `a <`
        -- The `:?:?` part makes it also
        -- work on Rust generics like `some_func::<T>()`
        cond.before_regex("%a+:?:?$", 3)
    ):with_move(function(m_opts)
        return m_opts.char == ">"
    end))
end
