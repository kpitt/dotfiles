local min_nvim_ver = "0.9.2"
if vim.fn.has("nvim-" .. min_nvim_ver) == 0 then
  vim.api.nvim_echo({
    { "This configuration requires Neovim >= " .. min_nvim_ver .. "\n", "ErrorMsg" },
    { "Press any key to exit", "MoreMsg" },
  }, true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end

-- Load options before lazy init loads the plugin modules.
-- This is needed to make sure options will be correctly applied after
-- installing missing plugins.
require("config.options")

-- bootstrap `lazy.nvim` and plugins
require("config.lazy")

-- Add shared '~/.vim' directories to `runtimepath` and `packpath`
local vim_dir = vim.fs.normalize('~/.vim')
local vimafter_dir = vim_dir .. '/after'
vim.opt.runtimepath:prepend(vim_dir)
vim.opt.runtimepath:append(vimafter_dir)
vim.opt.packpath:prepend(vim_dir)
vim.opt.packpath:append(vimafter_dir)

-- Shared config includes some settings/commands that require specific plugins,
-- so it must be loaded after `lazy.nvim` has been configured.
vim.cmd.source('~/.vimrc')

require("config")
