-- Iceberg theme for `nvim-lualine/lualine.nvim`
-- Ported directly from the embedded airline/lightline themes in
-- the `cocopon/iceberg.vim` repository.
-- License: MIT

-- stylua: ignore
local colors = (vim.o.background == 'light') and {
  base_fg     = '#8b98b6',
  base_bg     = '#cad0de',
  edge_fg     = '#e8e9ec',
  edge_bg     = '#757ca3',
  gradient_fg = '#e8e9ec',
  gradient_bg = '#9fa6c0',
  nc_fg       = '#8b98b6',
  nc_bg       = '#cad0de',
  mode_fg     = '#e8e9ec',
  insert_bg   = '#2d539e',
  replace_bg  = '#c57339',
  visual_bg   = '#668e3d',
  hilite_fg   = '#33374c',
} or {
  base_fg     = '#3e445e',
  base_bg     = '#0f1117',
  edge_fg     = '#17171b',
  edge_bg     = '#818596',
  gradient_fg = '#6b7089',
  gradient_bg = '#2e313f',
  nc_fg       = '#3e445e',
  nc_bg       = '#0f1117',
  mode_fg     = '#161821',
  insert_bg   = '#84a0c6',
  replace_bg  = '#e2a478',
  visual_bg   = '#b4be82',
  hilite_fg   = '#c6c8d1',
}

local theme = {
  inactive = {
    a = { fg = colors.nc_fg, bg = colors.nc_bg, gui = 'bold' },
    b = { fg = colors.nc_fg, bg = colors.nc_bg },
    c = { fg = colors.nc_fg, bg = colors.nc_bg },
  },
  normal = {
    a = { fg = colors.edge_fg, bg = colors.edge_bg, gui = 'bold' },
    b = { fg = colors.gradient_fg, bg = colors.gradient_bg },
    c = { fg = colors.base_fg, bg = colors.base_bg },
  },
  insert = {
    a = { fg = colors.mode_fg, bg = colors.insert_bg, gui = 'bold' },
  },
  replace = {
    a = { fg = colors.mode_fg, bg = colors.replace_bg, gui = 'bold' },
  },
  visual = {
    a = { fg = colors.mode_fg, bg = colors.visual_bg, gui = 'bold' },
  },
}

return {
  theme = theme,
  -- return the color palette also, in case it is needed for color overrides
  colors = colors,
}
