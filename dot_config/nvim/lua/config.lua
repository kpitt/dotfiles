require('nvim-treesitter.configs').setup {
  ensure_installed = { "lua", "vim", "vimdoc", "query" },
  auto_install = true,
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
  },
  playground = {
    enable = true,
  },
}

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
