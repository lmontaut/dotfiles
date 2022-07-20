---------
-- Gruvbox
---------
-- local plugins = require("gruvbox.plugins.highlights")
-- plugins["LSPReferenceRead"] = nil
require("gruvbox").setup({
  undercurl = true,
  underline = true,
  bold = true,
  italic = true, -- will make italic comments and special strings
  inverse = true, -- invert background for search, diffs, statuslines and errors
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  contrast = "soft", -- can be "hard" or "soft"
  -- Change highlight group
  overrides = {
      Comment = {fg = "#FF69B4"}
  }
})

vim.o.termguicolors = true
vim.o.background = "dark"
vim.cmd "colorscheme gruvbox"

---------
-- Github
---------
-- vim.cmd "set termguicolors"
-- require("github-theme").setup({
--   -- theme_style = "light_default",
--   theme_style = "light",
--   comment_style = "italic",
--   function_style = "bold",
--   sidebars = {"qf", "vista_kind", "terminal", "packer"},
--   dark_sidebar = true,
--
--   colors = { syntax = { func = "#D9138F", comment = "#2CA049" } },
--   -- Change the "hint" color to the "orange" color, and make the "error" color bright red
--   -- colors = {hint = "orange", error = "#ff0000"},
--
--   -- Overwrite the highlight groups
--   -- overrides = function(c)
--   --   return {
--   --     htmlTag = {fg = c.red, bg = "#282c34", sp = c.hint, style = "underline"},
--   --     DiagnosticHint = {link = "LspDiagnosticsDefaultHint"},
--   --     -- this will remove the highlight groups
--   --     TSField = {},
--   --   }
--   -- end
-- })

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

--------
-- catppuccin
--------
-- local catppuccin = require("catppuccin")
--
-- -- configure it
-- -- local colors = require'catppuccin.api.colors'.get_colors() -- fetch colors with API
-- catppuccin.setup({
--   transparent_background = false,
--   term_colors = false,
--   styles = {
--     comments = "italic",
--     conditionals = "italic",
--     loops = "NONE",
--     functions = "NONE",
--     keywords = "NONE",
--     strings = "NONE",
--     variables = "NONE",
--     numbers = "NONE",
--     booleans = "NONE",
--     properties = "NONE",
--     types = "NONE",
--     operators = "NONE",
--   },
--   integrations = {
--     treesitter = true,
--     native_lsp = {
--       enabled = true,
--       virtual_text = {
--         errors = "italic",
--         hints = "italic",
--         warnings = "italic",
--         information = "italic",
--       },
--       underlines = {
--         errors = "underline",
--         hints = "underline",
--         warnings = "underline",
--         information = "underline",
--       },
--     },
--     coc_nvim = false,
--     lsp_trouble = false,
--     cmp = true,
--     lsp_saga = true,
--     gitgutter = false,
--     gitsigns = true,
--     telescope = true,
--     nvimtree = {
--       enabled = true,
--       show_root = false,
--       transparent_panel = false,
--     },
--     neotree = {
--       enabled = false,
--       show_root = false,
--       transparent_panel = false,
--     },
--     which_key = false,
--     indent_blankline = {
--       enabled = true,
--       colored_indent_levels = false,
--     },
--     dashboard = true,
--     neogit = false,
--     vim_sneak = true,
--     fern = false,
--     barbar = false,
--     bufferline = true,
--     markdown = true,
--     lightspeed = false,
--     ts_rainbow = false,
--     hop = false,
--     notify = true,
--     telekasten = true,
--     symbols_outline = true,
--   }
-- })
-- catppuccin.remap({ Comment = { fg = "#FF69B4", style = "italic" }, })
-- vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
-- vim.cmd[[colorscheme catppuccin]]
