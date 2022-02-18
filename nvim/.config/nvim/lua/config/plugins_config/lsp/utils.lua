local M = {}

function M.show_line_diagnostics()
  local config = vim.lsp.diagnostics_config.float
  config.scope = "line"
  return vim.diagnostic.open_float(0, config)
end

return M
