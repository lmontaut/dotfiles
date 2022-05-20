-- This file contains basic keybindings
-- Keybindings related to plugins are handled by which-key, located in plugins_config/whichkey.lua

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

local opts = { noremap = true, silent = true }
-- local term_opts = { silent = true }

--Remap space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- keymap("", "<Space>", "<Nop>", opts) -- Remove if using which-key

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<M-h>", "<C-w>h", opts)
keymap("n", "<M-j>", "<C-w>j", opts)
keymap("n", "<M-k>", "<C-w>k", opts)
keymap("n", "<M-l>", "<C-w>l", opts)

-- Explorer
-- keymap("n", "<leader>e", "<cmd>Lex 30<cr>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", "<cmd>resize +2<CR>", opts)
keymap("n", "<C-Down>", "<cmd>resize -2<CR>", opts)
keymap("n", "<C-Left>", "<cmd>vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", "<cmd>vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", "<cmd>bnext<CR>", opts)
keymap("n", "<S-h>", "<cmd>bprevious<CR>", opts)

-- Better tabbing
keymap("n", ">" , ">>", opts)
keymap("n", "<" , "<<", opts)

-- Quit window
-- keymap("n", "<C-c>" , "<cmd>q<CR>", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)
-- ctrl + backspace to delete word
keymap("i", "<C-BS>", "<C-W>", opts)

-- Unindent
keymap("i", "<S-Tab>", "<C-d>", opts)

-- Visual --
-- -- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down -> Does not work
-- keymap("v", "J", "<cmd>m .+1<CR>==", opts)
-- keymap("v", "K", "<cmd>m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block -> Does not work
-- Move text up and down
-- keymap("x", "J", "<cmd>move '>+1<CR>gv-gv", opts)
-- keymap("x", "K", "<cmd>move '<-2<CR>gv-gv", opts)
-- keymap("x", "<A-j>", "<cmd>move '>+1<CR>gv-gv", opts)
-- keymap("x", "<A-k>", "<cmd>move '<-2<CR>gv-gv", opts)

-- -- Terminal --
-- -- TODO:
-- -- Better terminal navigation
-- -- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- -- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- -- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- -- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
