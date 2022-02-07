-----------------------------
-- GENERAL SETTINGS
lvim.log.level = "warn"
lvim.format_on_save = false

vim.g.gruvbox_flat_style  = "hard"
vim.g.gruvbox_transparent = true
vim.cmd("set termguicolors")
lvim.colorscheme = "gruvbox-flat"

vim.o.relativenumber = true
vim.wo.wrap = true
vim.wo.showbreak = ">>"

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
lvim.autocommands.custom_groups = {
  { "BufWinEnter", "*", "setlocal nospell" },
}

-----------------------------
-- ADDITIONAL PLUGINS
lvim.plugins = {
    -- colorschemes
    {'eddyekofo94/gruvbox-flat.nvim'},
    {"lunarvim/colorschemes"},
    {"folke/tokyonight.nvim"},

    -- cmp
    {'hrsh7th/cmp-cmdline'},

    -- Startify
    {'mhinz/vim-startify'},

    -- Latex
    {'lervag/vimtex'},

    -- Allows to align stuff! This is amazing.
    {"godlygeek/tabular"},

    -- Better errors/diagnostics etc.
    {
      "folke/trouble.nvim",
      cmd = "TroubleToggle",
    },
}

-- PLUGINS SETTINGS
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile

-----------------------------
-- KEYMAPPINGS [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- lvim.keys.normal_mode["<C-s>"]   = ":w<cr>"
-- lvim.keys.normal_mode["<C-c>"]   = ":q<cr>"
-- lvim.keys.normal_mode["<"]       = "<<"
-- lvim.keys.normal_mode[">"]       = ">>"
lvim.keys.insert_mode["<S-Tab>"] = {'<C-d>', { noremap = true }}
-- unmap a default keymapping:
-- lvim.keys.normal_mode["<C-Up>"] = false
-- edit a default keymapping:
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"

-- Which-key: add key-bindings and keep track of them!
-- Basically you register some mappings to a which-key options
local _, wk = pcall(require, "which-key")
-- options
local nopts = {
  mode = "n", -- NORMAL mode
  prefix = nil,
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}
local vopts = {
  mode = "v", -- NORMAL mode
  prefix = nil,
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}
-- mappings
local nmappings = {
  ["\\"]         = { "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>", "Comment" },
  ["<C-S>"]      = { ":w<cr>", "Save buffer" },
  ["<C-C>"]      = { ":q<cr>", "Quit window" },
  ["<"]          = { "<<", "Unindent" },
  [">"]          = { ">>", "Indent" },
  ["<C-H>"]      = { "<C-W>h", "Left window" },
  ["<C-L>"]      = { "<C-W>l", "Right window" },
  ["<C-J>"]      = { "<C-W>j", "Down window" },
  ["<C-K>"]      = { "<C-W>k", "Up window" },
  ["%"]          = { "%", "Next symbol" },
  ["<C-Q>"]      = { ":call QuickFixToggle()<CR>", "QuickFix" },
  ["<leader>1 "] = { ":Startify<CR>", "Startify menu" },
  ["<leader>["]  = { ":SSave<CR>y", "Session save" },
  ["<leader>]"]  = { ":SLoad<space>", "Session load" },
  ["<leader>'"]  = { ":SSave<CR>y:SClose<CR>", "Session quit" }
}
local vmappings = {
  ["\\"] = { "<ESC><CMD>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>", "Comment" }
}
-- registering
wk.register(nmappings, nopts)
wk.register(vmappings, vopts)

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
}

-- cmp
local _, cmp = pcall(require, "cmp")
-- With the following, you replace ONLY the ctrl+space mapping of cmp
lvim.builtin.cmp.mapping['<C-Space>'] = cmp.mapping(function()
        if cmp.visible() then
          cmp.close()
        else
          cmp.complete()
        end
      end, {"i", "s", "c"})

-- Autocomplete in the "/" research
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  },
})
-- Autocomplete in the ":" command line
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path'  },
  }, {
    { name = 'cmdline' }
  })
})

-- vimtex
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_compiler_latexmk = { build_dir = "build" }
vim.g.vimtex_enabled = 1
vim.g.vimtex_quickfix_mode = 0
vim.g.vimtex_complete_recursive_bib = 1

-- Telescope
-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
local _, actions = pcall(require, "telescope.actions")
-- With the following, you replace ALL the "mappings" table in telescope
lvim.builtin.telescope.defaults.mappings = {
  -- for input mode
  i = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-n>"] = actions.cycle_history_next,
    ["<C-p>"] = actions.cycle_history_prev,
  },
  -- for normal mode
  n = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
  },
}

-- Dashboard -> remove, I prefer startify
lvim.builtin.dashboard.active = false

-- Notify
lvim.builtin.notify.active = true

-- Terminal
lvim.builtin.terminal.active = true

-- NvimTree
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git  = 1
vim.cmd("autocmd Colorscheme * highlight NvimTreeNormal guibg=#21252B guifg=#9da5b3")

-- Treesitter
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "cpp",
  "cmake",
  "json",
  "lua",
  "python",
  "rust",
  "yaml",
  "markdown",
}
-- lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true


-- generic LSP settings

-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false

-- ---@usage Select which servers should be configured manually. Requires `:LvimCacheRest` to take effect.
-- See the full default list `:lua print(vim.inspect(lvim.lsp.override))`
-- vim.list_extend(lvim.lsp.override, { "pyright" })

-- ---@usage setup a server -- see: https://www.lunarvim.org/languages/#overriding-the-default-configuration
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pylsp", opts)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "black", filetypes = { "python" } },
--   { command = "isort", filetypes = { "python" } },
--   {
--     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

-- Startify
vim.g.startify_session_dir = '~/.cache/nvim/sessions'
vim.g.startify_lists = {
  { type = 'sessions', header = {' Sessions'} },
  { type = 'bookmarks', header= {' Bookmarks'} },
  { type = 'files', header= {' Files'} }
}
vim.g.startify_bookmarks = {
  { o = '~/orga/TODO.md' },
  { a = '~/dotfiles/cheatsheat.md' },
  { c = '~/dotfiles/.config/i3/config' },
  { i = '~/dotfiles/.config/nvim/init.vim' },
  { b = '~/dotfiles/.vim/keys.vim' },
  { p = '~/dotfiles/.vim/plugins.vim' },
  { s = '~/dotfiles/.vim/settings.vim' },
  { t = '~/dotfiles/.vim/my_snippets/tex.snippets' },
  { v = '~/dotfiles/.vimrc' },
  { z = '~/dotfiles/.zshrc' },
}

-- Automatically restart a session
vim.g.startify_session_autoload = 1
-- Let startify handle buffers
vim.g.startify_session_delete_buffers = 1

vim.g.startify_change_to_vcs_root = 1

-- Automatically update sessions
vim.g.startify_session_persistence = 1

-- Get rid of buffer on quit
vim.g.startify_enable_special = 0

vim.g.startify_custom_header = {
"  ____    ____                          ____     ___                ",
"  `MM'    `MM'                          `MM(     )M'                ",
"   MM      MM                            `MM.    d'                 ",
"   MM      MM   ____  ____    ___         `MM.  d' _____  ___   ___ ",
"   MM      MM  6MMMMb `MM(    )M'          `MM d' 6MMMMMb `MM    MM ",
"   MMMMMMMMMM 6M'  `Mb `Mb    d'            `MM' 6M'   `Mb MM    MM ",
"   MM      MM MM    MM  YM.  ,P              MM  MM     MM MM    MM ",
"   MM      MM MMMMMMMM   MM  M               MM  MM     MM MM    MM ",
"   MM      MM MM         `Mbd'               MM  MM     MM MM    MM ",
"   MM      MM YM    d9    YMP                MM  YM.   ,M9 YM.   MM ",
"  _MM_    _MM_ YMMMM9      M                _MM_  YMMMMM9   YMMM9MM_",
"                          d'                                        ",
"                      (8),P                                         ",
"                       YMM                                          "}
