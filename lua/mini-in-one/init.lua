local M = {}

---@class MiniInOneConfig
---@field ai? table
---@field align? table
---@field comment? table
---@field completion? table
---@field keymap? table
---@field move? table
---@field operators? table
---@field pairs? table
---@field snippets? table
---@field splitjoin? table
---@field surround? table
---@field basics? table
---@field bracketed? table
---@field bufremove? table
---@field clue? table
---@field cmdline? table
---@field deps? table
---@field diff? table
---@field extra? table
---@field files? table
---@field git? table
---@field input? table
---@field jump? table
---@field jump2d? table
---@field misc? table
---@field pick? table
---@field sessions? table
---@field visits? table
---@field animate? table
---@field base16? table
---@field colors? table
---@field cursorword? table
---@field hipatterns? table
---@field hues? table
---@field icons? table
---@field indentscope? table
---@field map? table
---@field notify? table
---@field starter? table
---@field statusline? table
---@field tabline? table
---@field trailspace? table
---@field doc? table
---@field fuzzy? table
---@field test? table

--- Sets up mini.nvim modules in one setup call
---
--- Usage:
--- ```lua
--- require("mini-in-one").setup({
---   comment = {}, -- use defaults
---   pick = {
---     window = {
---     config = { border = "rounded" },
---   },
--- })
--- ```
--- @param config MiniInOneConfig
--- @return table M The module table with loaded mini modules
function M.setup(config)
  for module_name, opts in pairs(config) do
    -- Try to load the module
    local ok, module = pcall(require, "mini." .. module_name)
    if not ok then
      vim.notify("mini-in-one: module 'mini." .. module_name .. "' not found", vim.log.levels.WARN)
      goto continue
    end

    -- Call setup
    if type(opts) == "table" then
      module.setup(opts)
      M[module_name] = module
    else
      vim.notify("mini-in-one: invalid options for " .. module_name, vim.log.levels.WARN)
    end

    ::continue::
  end
  return M
end

return M
