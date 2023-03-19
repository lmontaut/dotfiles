-- Reload Nvim
local M = {}

function M.reload()
  -- unload all modules
  require("config.plugins_config.utils").unload_lua_namespace("config")

  -- Save all buffers
  vim.cmd("silent wa")

  -- reset which_key
  local status_ok, which_key = pcall(require, "which-key")
  if not status_ok then
    return
  end
  which_key.reset()

  dofile(vim.fn.stdpath('config') .. '/init.lua')

  vim.notify("Nvim config successfully reloaded!", 'info', { title = 'Nvim config'})
end

return M
