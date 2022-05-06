local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	return
end

toggleterm.setup({
	size = 20,
	open_mapping = [[<C-\>]],
	hide_numbers = true,
	shade_filetypes = {},
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	-- direction = "horizontal",
	direction = "float",
	close_on_exit = true,
	shell = vim.o.shell,
	float_opts = {
		border = "curved",
		winblend = 0,
		highlights = {
			border = "Normal",
			background = "Normal",
		},
	},
})

function _G.set_terminal_keymaps()
  local opts = {noremap = true}
  -- vim.api.nvim_buf_set_keymap(0 , 't' , '<esc>' , [[<C-\><C-n>]]               , opts)
  vim.api.nvim_buf_set_keymap(0 , 't' , '<C-t>' , [[<C-\><C-n>]] , opts)
  -- vim.api.nvim_buf_set_keymap(0 , 't' , 'jk'    , [[<C-\><C-n>]]               , opts)
  -- vim.api.nvim_buf_set_keymap(0 , 't' , '<C-h>' , [[<C-\><C-n><C-W>h]]         , opts)
  -- vim.api.nvim_buf_set_keymap(0 , 't' , '<C-j>' , [[<C-\><C-n><C-W>j]]         , opts)
  -- vim.api.nvim_buf_set_keymap(0 , 't' , '<C-k>' , [[<C-\><C-n><C-W>k]]         , opts)
  -- vim.api.nvim_buf_set_keymap(0 , 't' , '<C-l>' , [[<C-\><C-n><C-W>l]]         , opts)
end

-- local opts = { noremap = true, silent = true }
-- vim.api.nvim_set_keymap('n' , '<C-t>' , "<Esc><cmd>1 ToggleTerm<CR>" , opts)

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

