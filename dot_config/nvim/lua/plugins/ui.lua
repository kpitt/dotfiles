return {
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      sections = {
        lualine_y = { "filetype" },
        lualine_z = {
          function()
            local line = vim.fn.line(".")
            local total = vim.fn.line("$")
            local vcolRange = vim.fn.virtcol(".", true)
            local vcol = vcolRange[1]
            local progress
            if line == 1 then
              progress = "Top"
            elseif line == total then
              progress = "Bot"
            else
              progress = string.format("%2d%%%%", math.floor(line / total * 100))
            end
            return string.format("%s %3d:%-2d", progress, line, vcol)
          end,
        },
      },
    },
  },
}
