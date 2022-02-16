-----------------------------
-- GENERAL SETTINGS
lvim.log.level = "warn"
lvim.format_on_save = false

-----------------------------
-- COLOR SCHEME
vim.g.gruvbox_flat_style  = "hard"
vim.g.gruvbox_transparent = true
-- vim.cmd("set termguicolors")
vim.opt.termguicolors = true
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
    {'EdenEast/nightfox.nvim'},
    {"savq/melange"},

    -- cmp
    {'hrsh7th/cmp-cmdline'},

    -- Startify
    {'mhinz/vim-startify'},

    -- Latex
    {'lervag/vimtex'},

    -- symbol outline
    {'simrat39/symbols-outline.nvim'},

    -- Allows to align stuff! This is amazing.
    {"godlygeek/tabular"},

    -- Better errors/diagnostics etc.
    {
      "folke/trouble.nvim",
      cmd = "TroubleToggle",
    },

    -- better(?) scrolling
    -- {
    --   "karb94/neoscroll.nvim",
    --   event = "WinScrolled",
    --   config = function()
    --   require('neoscroll').setup({
    --         -- All these keys will be mapped to their corresponding default scrolling animation
    --         mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>',
    --         '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
    --         hide_cursor = true,          -- Hide cursor while scrolling
    --         stop_eof = true,             -- Stop at <EOF> when scrolling downwards
    --         use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
    --         respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
    --         cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
    --         easing_function = nil,        -- Default easing function
    --         pre_hook = nil,              -- Function to run before the scrolling animation starts
    --         post_hook = nil,              -- Function to run after the scrolling animation ends
    --         })
    --   end
    -- },

    -- goto-preview
    {
      "rmagatti/goto-preview",
      config = function()
      require('goto-preview').setup {
            width = 120; -- Width of the floating window
            height = 25; -- Height of the floating window
            default_mappings = true; -- Bind default mappings
            debug = false; -- Print debug information
            opacity = 5; -- 0-100 opacity level of the floating window where 100 is fully transparent.
            post_open_hook = nil -- A function taking two arguments, a buffer and a window to be ran as a hook.
        }
      end
    },

    -- cmake
    {'cdelledonne/vim-cmake'},

    -- maximizer
    {"szw/vim-maximizer"},
}

-----------------------------
-- KEYMAPPINGS [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
lvim.lsp.diagnostics.virtual_text = true
-- lvim.keys.normal_mode["<C-s>"]   = ":w<cr>"
-- lvim.keys.normal_mode["<C-c>"]   = ":q<cr>"
-- lvim.keys.normal_mode["<"]       = "<<"
-- lvim.keys.normal_mode[">"]       = ">>"
lvim.keys.insert_mode["<S-Tab>"] = {'<C-d>', { noremap = true }}
-- unmap a default keymapping:
-- lvim.keys.normal_mode["<C-Up>"] = false
lvim.lsp.buffer_mappings.normal_mode["gp"] = nil
-- edit a default keymapping:
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"

-----------------------------
-- PLUGINS SETTINGS
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile

-- Dashboard -> remove, I prefer startify
lvim.builtin.dashboard.active = false
lvim.builtin.which_key.mappings[";"] = nil

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
-- plugins mappings
local nmappings = {
  -- comment
  ["\\"]         = { "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>", "Comment" },
  -- buffer/window save/quit
  ["<C-S>"]      = { "<cmd>w<CR>", "Save buffer" },
  ["<C-C>"]      = { "<cmd>q<CR>", "Quit window" },
  --indentation
  ["<"]          = { "<<", "Unindent" },
  [">"]          = { ">>", "Indent" },
  --window related
  ["<C-H>"]      = { "<C-W>h", "Left window" },
  ["<C-L>"]      = { "<C-W>l", "Right window" },
  ["<C-J>"]      = { "<C-W>j", "Down window" },
  ["<C-K>"]      = { "<C-W>k", "Up window" },
  ["%"]          = { "%", "Next symbol" },
  ["<C-Q>"]      = { "<cmd>call QuickFixToggle()<CR>", "QuickFix" },
  -- Startify
  ["<leader>1"] = { "<cmd>Startify<CR>", "Startify menu" },
  ["<leader>["]  = { ":SSave<CR>y", "Session save" },
  ["<leader>]"]  = { ":SLoad<space>", "Session load" },
  ["<leader>'"]  = { ":SSave<CR>y:SClose<CR>", "Session quit" },
  -- symbols-outline
  ["<leader>i"]  = { "<cmd>SymbolsOutline<CR>", "Symbols outline" },
  -- goto-preview
  ["gpd"] = { "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", "Preview definition"},
  ["gpi"] = { "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", "Preview implementation"},
  ["gP"] = { "<cmd>lua require('goto-preview').close_all_win()<CR>", "Preview close"},
  --      Only set if you have telescope installed
  ["gpr"] = { "<cmd>lua require('goto-preview').goto_preview_references()<CR>", "Preview references"},
  -- vim-maximizer
  ["<leader>;"] = { "<cmd>MaximizerToggle<CR>", "Zoom toggle"},
  -- bufferline
  ["<leader>b{"] = { "<cmd>BufferLineMovePrev<CR>", "Tab move prev"},
  ["<leader>b}"] = { "<cmd>BufferLineMoveNext<CR>", "Tab move next"},
}
local vmappings = {
  ["\\"] = { "<ESC><CMD>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>", "Comment" }
}
-- registering
wk.register(nmappings, nopts)
wk.register(vmappings, vopts)

-- which_key remap some stuff associated to space bar
lvim.builtin.which_key.mappings["bc"] = { "<cmd>bd!<CR>" , "Close buffer" }

-- terminal
lvim.builtin.terminal.open_mapping = [[<c-p>]]

-- cmake
lvim.builtin.which_key.mappings["c"] = {
  name = "+CMake",
  g = { ":CMakeGenerate -DCMAKE_INSTALL_PREFIX=$CONDA_PREFIX", "Generate" },
  r = { ":CMakeGenerate Release -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$CONDA_PREFIX", "Generate release" },
  d = { ":CMakeGenerate Debug -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX=$CONDA_PREFIX", "Generate debug" },
  i = { "<cmd>CMakeInstall<CR>", "Install" },
  s = { ":CMakeSwitch<space>", "Switch" },
  b = { ":CMakeBuild<space>", "Build" },
  o = { "<cmd>CMakeOpen<CR>", "Open" },
  c = { "<cmd>CMakeClose<CR>", "Close" },
  w = { "<cmd>CMakeClean<CR>", "Wipe/clean" },
}

-- Trouble
-- TIP: Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
}

-- symbols-outline
vim.g.symbols_outline = {
  width = 50,
  auto_preview = true
}

-- Telescope
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
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
  { c = '~/dotfiles/.config/lvim/config.lua' },
  { o = '~/orga/TODO.md' },
  { i = '~/dotfiles/.config/i3/config' },
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
