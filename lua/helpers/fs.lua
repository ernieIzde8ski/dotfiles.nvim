local vimfs = vim.fs

local M = {
    vfs = vim.fs,
}

---Find an ancestor starting from the given path.
---@param name string Name of the file to search for.
---@param start_path string Path to start from.
---@return string | nil file The file, if it exists.
function M:find_ancestor(name, start_path)
    return self.vfs.find(name, { path = start_path, upward = true })[1]
end

---Find a root path containing the given ancestor.
---@param ancestor string Name of the file to search for.
---@param start_path string to start from. Should be the current working directory.
---@return string | nil root The root directory, if can be found.
function M:find_root(ancestor, start_path)
    local res = self:find_ancestor(ancestor, start_path)
    if res ~= nil then
        return vimfs.dirname(res)
    end
end

return M
