-- Need to load `lazy.nvim` plugins before sourcing shared config.
require('config.lazy')

-- Add shared '~/.vim' directories to `runtimepath` and `packpath`
local vim_dir = vim.fs.normalize('~/.vim')
local vimafter_dir = vim_dir .. '/after'
vim.opt.runtimepath:prepend(vim_dir)
vim.opt.runtimepath:append(vimafter_dir)
vim.opt.packpath:prepend(vim_dir)
vim.opt.packpath:append(vimafter_dir)

vim.cmd.source('~/.vimrc')

require('config')
