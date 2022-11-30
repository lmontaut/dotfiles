local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  print "Failed to load lspconfig"
  return
end

require ("config.plugins_config.lsp.utils")
require("config.plugins_config.lsp.lsp-installer")
require("config.plugins_config.lsp.handlers").setup()
-- require "config.plugins_config.lsp.null-ls"

-- ccls
