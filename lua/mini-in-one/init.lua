---@module "mini-in-one.types"
local M = {}

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
--- @param config MiniInOneConfig Configuration table where keys are mini module names
--- @return MiniInOne
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
