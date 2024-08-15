---@generic T
---@class Set<T>: { [T] : boolean }

return {

    ---Returns a new set.
    ---@generic T
    ---@param list T[] Input table to convert into set
    ---@return Set<T>  : Set from input table
    new = function(list)
        local res = {}
        for _, value in ipairs(list) do
            res[value] = true
        end
        return res
    end,
}
