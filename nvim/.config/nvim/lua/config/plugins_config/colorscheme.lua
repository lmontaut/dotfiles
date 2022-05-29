---------
-- Gruvbox
---------
-- if not pcall(require, "gruvbox") then
--   error "nvim-treesitter requires a more recent Neovim nightly version!"
-- end

-- local plugins = require("gruvbox.plugins.highlights")
-- plugins["LSPReferenceRead"] = nil

-- vim.o.termguicolors = true
-- vim.o.background = "light"
-- vim.cmd "colorscheme gruvbox"
-- vim.cmd "set termguicolors"

---------
-- Github
---------
vim.cmd "set termguicolors"
require("github-theme").setup({
  -- theme_style = "light_default",
  theme_style = "light",
  comment_style = "italic",
  function_style = "bold",
  sidebars = {"qf", "vista_kind", "terminal", "packer"},
  dark_sidebar = true,

  colors = { syntax = { func = "#D9138F", comment = "#2CA049" } },
  -- Change the "hint" color to the "orange" color, and make the "error" color bright red
  -- colors = {hint = "orange", error = "#ff0000"},

  -- Overwrite the highlight groups
  -- overrides = function(c)
  --   return {
  --     htmlTag = {fg = c.red, bg = "#282c34", sp = c.hint, style = "underline"},
  --     DiagnosticHint = {link = "LspDiagnosticsDefaultHint"},
  --     -- this will remove the highlight groups
  --     TSField = {},
  --   }
  -- end
})

--------
-- Neon
--------
-- vim.cmd[[colorscheme neon]]
-- vim.g.neon_style = "light"
-- vim.o.background = "light"
-- vim.g.neon_italic_keyword = true
-- vim.g.neon_italic_function = true

--------
-- Material
--------
-- vim.cmd[[colorscheme material]]
-- vim.o.background = "light"
-- vim.g.material_style = "lighter"

--------
-- Tokyo night
--------
-- vim.cmd[[colorscheme tokyonight]]
-- vim.o.background = "light"
-- vim.g.tokyonight_style = "day"
