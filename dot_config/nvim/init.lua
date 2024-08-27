-- Add shared '~/.vim' directory to runtimepath
local vimdir = vim.fs.normalize('~/.vim')
vim.opt.runtimepath:prepend(vimdir)
vim.opt.runtimepath:append(vimdir .. '/after')
vim.o.packpath = vim.o.runtimepath

vim.cmd.source('~/.vimrc')

require('config')
