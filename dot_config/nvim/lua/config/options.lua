-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

vim.g.snacks_animate = false -- disable all snacks animations
vim.g.trouble_lualine = false -- don't show document symbols in status line

local opt = vim.opt
opt.relativenumber = false -- use absolute line numbers
