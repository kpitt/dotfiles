local function augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("json_conceal"),
  pattern = { "json", "jsonc", "json5" },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
  desc = "Fix conceallevel for json files",
})
