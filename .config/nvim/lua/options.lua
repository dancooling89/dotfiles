local g = vim.g
local set = vim.opt

-- Set the leader key
g.mapleader = ' '

-- Set the correct tab length
set.tabstop = 2
set.softtabstop = 2
set.shiftwidth = 2

-- Set relative line numbers only when in normal mode
set.number = true
set.relativenumber = true
vim.cmd([[
	augroup numbertoggle
		autocmd!
		autocmd InsertEnter * :set norelativenumber
		autocmd InsertLeave * :set relativenumber
	augroup END
]])
vim.cmd([[
	augroup terminalsettings
		autocmd!
		autocmd TermEnter * :setlocal nonumber
	augroup END
]])

-- Set options for the theme
set.termguicolors = true

-- Keep the gutter open at all times to prevent screen jumping
set.signcolumn = 'yes'
