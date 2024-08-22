---@generic T
---@class Set<T>: { [T] : boolean }

return {

    ---Returns a new set.
    ---@generic T
    ---@param list T[] Input table to convert into set
    ---@return {[T]: true}  : Set from input table
    new = function(list)
        local res = {}
        for _, value in ipairs(list) do
            res[value] = true
        end
        return res
    end,

    ---Returns the union of two or more sets.
    ---@generic T
    ---@param sets Array<{[T]: true}>
    ---@returns {[T]: true}
    union = function(sets)
        local res = {}
        for _, set in ipairs(sets) do
            for key, _ in pairs(set) do
                res[key] = true
            end
        end
        return res
    end,

    ---Returns the set as an array.
    ---@generic T
    ---@param set {[T]: true}
    ---@returns T[]
    as_array = function(set)
        local res = {}
        for key, _ in pairs(set) do
            table.insert(res, key)
        end
        return res
    end,
}
