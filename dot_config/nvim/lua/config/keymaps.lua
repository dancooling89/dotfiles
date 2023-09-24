-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<C-Left>", "<Cmd>NvimTmuxNavigateLeft<CR>", { silent = true })
vim.keymap.set("n", "<C-Down>", "<Cmd>NvimTmuxNavigateDown<CR>", { silent = true })
vim.keymap.set("n", "<C-Up>", "<Cmd>NvimTmuxNavigateUp<CR>", { silent = true })
vim.keymap.set("n", "<C-Right>", "<Cmd>NvimTmuxNavigateRight<CR>", { silent = true })
