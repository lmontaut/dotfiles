local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  print "Packer failed to load."
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- Put plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "folke/lua-dev.nvim" -- useful for lua dev
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "folke/which-key.nvim" -- Remember keybindings
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  use {
    'numToStr/Comment.nvim',
    tag = 'v0.6',
    config = function()
      require('Comment').setup()
    end
  }
  use "JoosepAlviste/nvim-ts-context-commentstring"
  use 'antoinemadec/FixCursorHold.nvim'

  -- Buffers, tab, line
  use "akinsho/bufferline.nvim"
  use "moll/vim-bbye" -- better closing buffers
  use "nvim-lualine/lualine.nvim"

  -- Toggleterm
  use "akinsho/toggleterm.nvim"

  -- maximizer
  use "szw/vim-maximizer"

  -- Startify
  -- use 'mhinz/vim-startify'
  use 'glepnir/dashboard-nvim'

  -- Allows to align stuff! This is amazing.
  use "godlygeek/tabular"

  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "hrsh7th/cmp-nvim-lsp"
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lua"

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
  use "b0o/schemastore.nvim" -- more json files settings support

  -- TODO: look into null-ls --> format/lint/code actions from other sources than LSPs
  -- use "jose-elias-alvarez/null-ls.nvim"

  -- TODO: look into DAP
  use {
    "mfussenegger/nvim-dap",
    opt = true,
    event = "BufReadPre",
    module = { "dap" },
    wants = { "nvim-dap-virtual-text", "DAPInstall.nvim", "nvim-dap-ui", "which-key.nvim" },
    requires = {
    },
    config = function()
      require("config.plugins_config.debugger").setup()
    end,
  }

  use "rcarriga/nvim-dap-ui"
  use "nvim-telescope/telescope-dap.nvim"
  use "theHamsta/nvim-dap-virtual-text"
  use {
    "Pocco81/DAPInstall.nvim",
    commit = "24923c3"
  }

  -- TODO: look into vim test
  -- use "vim-test/vim-test"

  -- Colorschemes
  use "lmontaut/gruvbox.nvim"
  -- use "$HOME/louis_nvim_plugins/gruvbox.nvim"

  -- Telescope
  use "nvim-telescope/telescope.nvim"
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }

  -- Nvim tree
  use "kyazdani42/nvim-web-devicons"
  use "kyazdani42/nvim-tree.lua"

  -- Git
  use "lewis6991/gitsigns.nvim"

  -- Notify
  use { "rcarriga/nvim-notify",
    config = function()
      vim.defer_fn(function() require('config.plugins_config.notify') end, 2000)
    end,
    event = "BufRead",
  }

  -- cmake
  use 'cdelledonne/vim-cmake'

  -- goto-preview
  use { "rmagatti/goto-preview",
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
  }

  -- Latex
  use "lervag/vimtex"
  -- Markdown
  use "iamcco/markdown-preview.nvim"

  -- Better errors/diagnostics etc.
  use { "folke/trouble.nvim", cmd = "TroubleToggle" }

  -- symbol outline
  -- use "lmontaut/symbols-outline.nvim"
  use 'simrat39/symbols-outline.nvim'

  -- lightbulb when code action is available --> handlded by saga
  -- use "kosayoda/nvim-lightbulb"

  -- LSP saga
  use "tami5/lspsaga.nvim"

  -- Transparent
  use "xiyaowong/nvim-transparent"

  -- Orgmode
  use { 'nvim-orgmode/orgmode', config = function()
    require('orgmode').setup {}
  end
  }

  -- Sniprun -- TODO
  -- use {}


  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
