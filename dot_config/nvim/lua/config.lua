require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "lua",
    "vim",
    "vimdoc",
    "query",
    "regex",
    "markdown",
    "markdown_inline",
  },
  auto_install = true,
  highlight = {
    disable = function()
      -- disable if 'filetype' option includes 'chezmoitmpl'
      if string.find(vim.bo.filetype, 'chezmoitmpl') then
        return true
      end
    end,
  },
  incremental_selection = { enable = true },
}

require("config.keymaps")

--- Require an optional module.
-- @param name The name of the module.
-- @return module or nil
-- @return error message
local function want(name)
  local out; if xpcall(
      function()  out = require(name) end,
      function(e) out = e end)
  then return out          -- success
  else return nil, out end -- error
end

-- Load local-only configuration, if available.
want("config.local")
