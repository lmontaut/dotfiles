-- settings for gruvbox
if not pcall(require, "gruvbox") then
  error "nvim-treesitter requires a more recent Neovim nightly version!"
end

local plugins = require("gruvbox.plugins.highlights")
plugins["LSPReferenceRead"] = nil

vim.o.termguicolors = true
vim.o.background = "light"
vim.cmd "colorscheme gruvbox"

-- vim.cmd [[ colo
-- try
--   colorscheme gruvbox
--   set termguicolors
--   " hi Normal guibg=NONE ctermbg=NONE
-- catch /^Vim\%((\a\+)\)\=:E185/
--   colorscheme default
--   set background=dark
-- ]]
