local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  print "Plugin which-key failed to load."
  return
end

local setup = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = false, -- adds help for motions
      text_objects = false, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = false, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "rounded", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

which_key.setup(setup)

---------------------
-- KEYBINDINGS
local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float"})

function _LAZYGIT_TOGGLE()
	lazygit:toggle()
end

local leader_nopts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local leader_nmappings = {
  ["e"] = { "<cmd>NvimTreeToggle<CR>", "Explorer" },

  -- vim-maximizer
  [";"] = { "<cmd>MaximizerToggle<CR>", "Zoom toggle"},

  -- startify
  ["1"] = { "<cmd>Startify<CR>"      , "Startify menu" } ,
  ["["] = { ":SSave<CR>y"            , "Session save" }  ,
  ["]"] = { ":SLoad<space>"          , "Session load" }  ,
  ["'"] = { ":SSave<CR>y:SClose<CR>" , "Session quit" }  ,

  -- symbols-outline
  ["i"]  = { "<cmd>SymbolsOutline<CR>", "Symbols outline" },

  f = {
    name = "Find",
    f = { require("config.plugins_config.telescope_functions.telescope_finder").find_project_files , "Find file" }          ,
    b = { "<cmd>Telescope buffers<CR>"                                                             , "Find buffer" }        ,
    d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<CR>"                                   , "Buffer Diagnostics" } ,
    D = { "<cmd>Telescope diagnostics<CR>"                                                         , "All diagnostics" }    ,
    g = { "<cmd>Telescope live_grep<CR>"                                                           , "Grep" }               ,
    r = { "<cmd>Telescope oldfiles<CR>"                                                            , "Open Recent File" }   ,
    h = { "<cmd>Telescope help_tags<CR>"                                                           , "Find Help" }          ,
    k = { "<cmd>Telescope keymaps<CR>"                                                             , "Keymaps" }            ,
    R = { "<cmd>Telescope registers<CR>"                                                           , "Registers" }          ,
    M = { "<cmd>Telescope man_pages<CR>"                                                           , "Man Pages" }          ,
    C = { "<cmd>Telescope commands<CR>"                                                            , "Commands" }           ,
  },

  b = {
    name = "Buffers",
    b = { "<cmd>Telescope buffers<CR>"                                , "Opened buffers" }             ,
    c = { "<cmd>Bdelete!<CR>"                                         , "Close buffer" }               ,
    j = { "<cmd>BufferLinePick<cr>"                                   , "Jump" }                       ,
    p = { "<cmd>BufferLineCyclePrev<cr>"                              , "Previous" }                   ,
    e = { "<cmd>BufferLinePickClose<cr>"                              , "Pick which buffer to close" } ,
    h = { "<cmd>BufferLineCloseLeft<cr>"                              , "Close all to the left" }      ,
    l = { "<cmd>BufferLineCloseRight<cr>"                             , "Close all to the right" }     ,
    x = { "<cmd>BufferLineCloseRight<cr><cmd>BufferLineCloseLeft<cr>" , "Close all but current" }      ,
    D = { "<cmd>BufferLineSortByDirectory<cr>"                        , "Sort by directory" }          ,
    L = { "<cmd>BufferLineSortByExtension<cr>"                        , "Sort by language" }           ,
    ["{"] = { "<cmd>BufferLineMovePrev<CR>"                           , "Tab move prev"}               ,
    ["}"] = { "<cmd>BufferLineMoveNext<CR>"                           , "Tab move next"}               ,
  },

  c = {
    name = "CMake",
    g = { ":CMakeGenerate -DCMAKE_INSTALL_PREFIX=$CONDA_PREFIX", "Generate" },
    r = { ":CMakeGenerate Release -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$CONDA_PREFIX", "Generate release" },
    d = { ":CMakeGenerate Debug -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX=$CONDA_PREFIX", "Generate debug" },
    i = { "<cmd>CMakeInstall<CR>", "Install" },
    s = { ":CMakeSwitch<space>", "Switch" },
    b = { ":CMakeBuild<space>", "Build" },
    o = { "<cmd>CMakeOpen<CR>", "Open" },
    c = { "<cmd>CMakeClose<CR>", "Close" },
    w = { "<cmd>CMakeClean<CR>", "Wipe/clean" },
  },

  g = {
    name = "Git",
    o = { "<cmd>Telescope git_status<CR>"   , "Open changed file" } ,
    b = { "<cmd>Telescope git_branches<CR>" , "Checkout branch" }   ,
    c = { "<cmd>Telescope git_commits<CR>"  , "Checkout commit" }   ,
    l = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>"  , "Lazygit" }           ,
  },

  m = {
    name = "Markdown",
    t = { "<cmd>MarkdownPreviewToggle<CR>"   , "Toggle" } ,
    o = { "<cmd>MarkdownPreview<CR>"   , "Start" } ,
    c = { "<cmd>MarkdownPreviewStop<CR>"   , "Stop" } ,
  },

  l = {
    name = "LSP",
    -- a = { "<cmd>lua require('config.plugins_config.telescope_functions.code_actions').code_actions()<CR>" , "Code Action" },
    a = { "<cmd>Lspsaga code_action<CR>"                     , "Code Action" }        ,
    r = { "<cmd>Lspsaga rename<CR>"                          , "Rename" }             ,
    d = { "<cmd>Trouble document_diagnostics<CR>"            , "Buffer diagnostics" } ,
    D = { "<cmd>Trouble lsp_workspace_diagnostics<CR>"       , "All diagnostics" }    ,
    s = { "<cmd>Telescope lsp_document_symbols<CR>"          , "Document Symbols" }   ,
    S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>" , "Workspace Symbols" }  ,
    f = { "<cmd>lua vim.lsp.buf.formatting()<CR>"            , "Format" }             ,
    i = { "<cmd>LspInfo<CR>"                                 , "Info" }               ,
    I = { "<cmd>LspInstallInfo<CR>"                          , "Installer Info" }     ,
    j = { "<cmd>Lspsaga diagnostic_jump_next<CR>"            , "Next Diagnostic" }    ,
    k = { "<cmd>Lspsaga diagnostic_jump_prev<CR>"            , "Prev Diagnostic" }    ,
  },

  v = {
    name = "Nvim",
    r = { "<cmd>lua require('config.plugins_config.reload_config').reload()<CR>"               , "Reload config" }      ,
    p = { "<cmd>e $HOME/dotfiles/nvim/.config/nvim/lua/config/plugins.lua<CR>"                 , "Edit plugins" }       ,
    w = { "<cmd>e $HOME/dotfiles/nvim/.config/nvim/lua/config/plugins_config/whichkey.lua<CR>" , "Edit whichkey"}       ,
    k = { "<cmd>Telescope keymaps<CR>"                                                         , "Keymaps" }            ,
    t = { "<cmd>TransparentToggle<CR>"                                                         , "Toggle transparent" } ,
    q = { "<cmd>qa!<CR>"                                                                       , "Quit vim" }           ,
  },

  -- t = { --> replaced lsp reference/diagnostics
  --   name = "Trouble",
  --   r = { "<cmd>Trouble lsp_references<cr>"            , "References" }         ,
  --   f = { "<cmd>Trouble lsp_definitions<cr>"           , "Definitions" }        ,
  --   d = { "<cmd>Trouble document_diagnostics<cr>"      , "Buffer diagnostics" } ,
  --   q = { "<cmd>Trouble quickfix<cr>"                  , "QuickFix" }           ,
  --   l = { "<cmd>Trouble loclist<cr>"                   , "LocationList" }       ,
  --   w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>" , "All diagnostics" }    ,
  -- },

  T = {
    name = "Treesitter",
    i = { ":TSConfigInfo<CR>", "Info" },
  },

  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>"                                 , "Compile" }    ,
    i = { "<cmd>PackerInstall<cr>"                                 , "Install" }    ,
    r = { "<cmd>lua require('lvim.plugin-loader').recompile()<cr>" , "Re-compile" } ,
    s = { "<cmd>PackerSync<cr>"                                    , "Sync" }       ,
    S = { "<cmd>PackerStatus<cr>"                                  , "Status" }     ,
    u = { "<cmd>PackerUpdate<cr>"                                  , "Update" }     ,
  },

  d = {
    name = "Debug",
    u = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
    t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
    s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
    p = { "<cmd>lua require'dap'.pause.toggle()<cr>", "Pause" },
    x = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
    r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
    i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
    o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
    U = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
    b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
    q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
    c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
    d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
    e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
    R = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run to Cursor" },
    E = { "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>", "Evaluate Input" },
    C = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", "Conditional Breakpoint" },
    g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
    h = { "<cmd>lua require'dap.ui.widgets'.hover()<cr>", "Hover Variables" },
    S = { "<cmd>lua require'dap.ui.widgets'.scopes()<cr>", "Scopes" },
  },
}
which_key.register(leader_nmappings, leader_nopts)

local leader_vopts = {
    mode = "v",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = false,
}

local leader_vmappings = {
    name = "Debug",
    e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
}
which_key.register(leader_vmappings, leader_vopts)

local ctrl_nopts = {
  mode = "n", -- NORMAL mode
  prefix = nil,
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}
local ctrl_nmappings = {
  ["<C-c>"] = { "<cmd>q!<CR>", "Quit window" },
  ["<C-w>s"] = { "<cmd>vsplit<CR>", "Vertical split" },
  ["<C-w>a"] = { "<cmd>split<CR>", "Horizontal split" },
}
which_key.register(ctrl_nmappings, ctrl_nopts)

local ipython = Terminal:new({ cmd = "ipython", hidden = true, direction = "float" })

function _PYTHON_TOGGLE()
	ipython:toggle()
end

local htop = Terminal:new({ cmd = "htop", hidden = true, direction = "float"})

function _HTOP_TOGGLE()
	htop:toggle()
end

local ranger = Terminal:new({ cmd = "ranger", hidden = true, direction = "float"})

function _RANGER_TOGGLE()
	ranger:toggle()
end

local nmappings = {
  -- Comment
  ["\\"] = { "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>" , "Comment" }         ,
  -- Terminal
  ["<C-]>"] = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>" , "Lazygit" } ,
  ["<C-p>"] = { "<cmd>lua _PYTHON_TOGGLE()<CR>"  , "IPython" } ,
  ["<C-x>"] = { "<cmd>lua _HTOP_TOGGLE()<CR>"    , "Htop" }    ,
  ["<C-q>"] = { "<cmd>lua _RANGER_TOGGLE()<CR>"  , "Ranger" }  ,
  -- Show line diagnostic
  ["gl"] = { "<cmd>Lspsaga show_line_diagnostics<CR>" , "Line diagnostic" } ,
  -- goto-preview
  ["gr"] = { "<cmd>Trouble lsp_references<CR>"                                       , "References" }            ,
  ["gp"] = {
    name = "Goto Preview"                                                            ,
    d = { "<cmd>lua require('goto-preview').goto_preview_definition()<CR>"           , "Preview definition"}     ,
    i = { "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>"       , "Preview implementation"} ,
    r = { "<cmd>lua require('goto-preview').goto_preview_references()<CR>"           , "Preview references"}     , -- Only set if you have telescope installed
    c = { "<cmd>lua require('goto-preview').close_all_win()<CR>"                     , "Preview close"}          ,
  }
}
local nopts = {
  mode = "n", -- NORMAL mode
  prefix = nil,
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}
which_key.register(nmappings, nopts)
local vmappings = {
  -- Comment
  ["\\"] = { "<ESC><CMD>lua require(\"Comment.api\").toggle_linewise_op(vim.fn.visualmode())<CR>", "Comment" },
}
local vopts = {
  mode = "v", -- VISUAL mode
  prefix = nil,
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}
which_key.register(vmappings, vopts)

local tmappings = {
  -- Terminal
  ["<C-]>"] = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>" , "Lazygit" } ,
  ["<C-p>"] = { "<cmd>lua _PYTHON_TOGGLE()<CR>"  , "IPython" } ,
  ["<C-x>"] = { "<cmd>lua _HTOP_TOGGLE()<CR>"    , "Htop" }    ,
  ["<C-q>"] = { "<cmd>lua _RANGER_TOGGLE()<CR>"  , "Ranger" }  ,
}
local topts = {
  mode = "t", -- TERMINAL mode
  prefix = nil,
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}
which_key.register(tmappings, topts)
