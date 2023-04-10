require('nvim-treesitter.configs').setup {
  ensure_installed = { "lua", "vim", "vimdoc", "query" },
  auto_install = true,
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
  },
}
