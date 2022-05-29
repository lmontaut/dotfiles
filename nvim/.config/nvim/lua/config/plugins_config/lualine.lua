local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local colors = {
  bg = "#EEE9DF",
  fg = "#202328",
  yellow = "#ECBE7B",
  cyan = "#008080",
  darkblue = "#081633",
  green = "#98be65",
  orange = "#FF8800",
  violet = "#a9a1e1",
  magenta = "#c678dd",
  purple = "#c678dd",
  blue = "#51afef",
  red = "#ec5f67",
}

local window_width_limit = 70

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand "%:t") ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > window_width_limit
  end,
  -- check_git_workspace = function()
  --   local filepath = vim.fn.expand "%:p:h"
  --   local gitdir = vim.fn.finddir(".git", filepath .. ";")
  --   return gitdir and #gitdir > 0 and #gitdir < #filepath
  -- end,
}

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  symbols = { error = " ", warn = " ", info = " ", hint = " " },
  color = {},
  cond = conditions.hide_in_width,
}

local diff = {
	"diff",
	colored = true,
	symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
  cond = conditions.hide_in_width
}

local mode = {
  function()
    return " "
  end,
  padding = { left = 0, right = 0 },
  color = {},
  cond = nil,
}

local branch = {
	"branch",
	icon = "",
  color = { gui = "bold" },
	icons_enabled = true,
}

local filename = {
  'filename',
  file_status = true,      -- Displays file status (readonly status, modified status)
  path = 1,                -- 0: Just the filename
                           -- 1: Relative path
                           -- 2: Absolute path
                           -- 3: Absolute path, with tilde as the home directory

  shorting_target = 40,    -- Shortens path to leave 40 spaces in the window
                           -- for other components. (terrible name, any suggestions?)
  symbols = {
    modified = '[+]',      -- Text to show when the file is modified.
    readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
    unnamed = '[No Name]', -- Text to show for unnamed buffers.
  }
}

-- cool function for progress
local progress = function()
	local current_line = vim.fn.line(".")
	local total_lines = vim.fn.line("$")
	local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
	local line_ratio = current_line / total_lines
	local index = math.ceil(line_ratio * #chars)
	return chars[index]
end

local python_env = {
  function()
    local utils = require "config.plugins_config.utils"
    if vim.bo.filetype == "python" or vim.bo.filetype == "cpp" then
      local venv = os.getenv "CONDA_DEFAULT_ENV"
      if venv then
        return string.format("  (%s)", utils.env_cleanup(venv))
      end
      venv = os.getenv "VIRTUAL_ENV"
      if venv then
        return string.format("  (%s)", utils.env_cleanup(venv))
      end
      return ""
    end
    return ""
  end,
  color = { fg = colors.green },
  cond = conditions.hide_in_width,
}

local treesitter = {
  function()
    local b = vim.api.nvim_get_current_buf()
    if next(vim.treesitter.highlighter.active[b]) then
      return ""
    end
    return ""
  end,
  color = { fg = colors.green },
  cond = conditions.hide_in_width,
}

local lsp = {
  function(msg)
    msg = msg or "LS Inactive"
    local buf_clients = vim.lsp.buf_get_clients()
    if next(buf_clients) == nil then
      -- TODO: clean up this if statement
      if type(msg) == "boolean" or #msg == 0 then
        return "LS Inactive"
      end
      return msg
    end
    -- local buf_ft = vim.bo.filetype
    local buf_client_names = {}

    -- add client
    for _, client in pairs(buf_clients) do
      if client.name ~= "null-ls" then
        table.insert(buf_client_names, client.name)
      end
    end

    -- TODO: add formatter
    -- local formatters = require "config.plugins_config.formatters"
    -- local supported_formatters = formatters.list_registered(buf_ft)
    -- vim.list_extend(buf_client_names, supported_formatters)

    -- TODO: add linter
    -- local linters = require "config.plugins_config.linters"
    -- local supported_linters = linters.list_registered(buf_ft)
    -- vim.list_extend(buf_client_names, supported_linters)

    return "[" .. table.concat(buf_client_names, ", ") .. "]"
  end,
  color = { gui = "bold" },
  cond = conditions.hide_in_width,
}

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline", "startify" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { mode },
		lualine_b = { branch, filename },
		lualine_c = { python_env, diff },
		-- lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_x = { diagnostics, treesitter, lsp },
		lualine_y = { "fileformat", "filetype" },
    lualine_z = { progress },
	},
	inactive_sections = {
		lualine_a = { "filename" },
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})
