local opt = vim.opt
local g   = vim.g

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

return {
  -- main color scheme
  {
    "cocopon/iceberg.vim",
    lazy = false,
    priority = 1000,
    init = function()
      -- Iceberg scheme customizations
      local group = augroup("iceberg-scheme-overrides", { clear = true })
      autocmd("ColorScheme", {
        pattern = "iceberg",
        group = group,
        desc = "Iceberg color scheme customizations",
        command = [[
          hi Visual guibg=#313752
          hi VisualNOS guibg=#313752
          hi QuickFixLine guibg=#313752
          hi SneakScope guibg=#313752
        ]],
      })
    end,
  },

  -- status line and tab bar
  {
    "vim-airline/vim-airline",
    init = function()
      opt.showmode = false  -- only show mode in the airline status bar
      g["airline#parts#ffenc#skip_expected_string"] = "utf-8[unix]"
      -- simplify the file position format
      g.airline_section_z = "%#__accent_bold#%l/%L:%v%#__restore__# %p%%"
      -- enable powerline fonts if available
      g.airline_powerline_fonts = 0
      if vim.env.TERM:match("kitty") then
        -- Powerline fonts are always available if running Kitty terminal.
        g.airline_powerline_fonts = 1
      end
      if g.airline_powerline_fonts == 1 then
        -- override some of the default powerline symbols (using Nerd Fonts)
        if not g.airline_symbols then
          g.airline_symbols = {}
        end
        g.airline_symbols = vim.tbl_extend('force', g.airline_symbols, {
          colnr = " :", --= " \u{e0a3}:"
          dirty = "⚡︎",  --= "\u{26a1}\u{fe0e}"
        })
      end
      -- extensions configuration
      g["airline#extensions#tabline#enabled"] = 1
    end,
  },
  { "vim-airline/vim-airline-themes" },

  -- chezmoi plugin must be loaded early, before other syntax or filetype plugins
  {
    "alker0/chezmoi.vim",
    lazy = false,
    priority = 500,
  },

  -- General
  { "tpope/vim-surround" },
  { "tpope/vim-repeat" },
  { "tpope/vim-unimpaired" },

  { "kana/vim-textobj-user" },
  {
    "kana/vim-textobj-entire",
    dependencies = { "kana/vim-textobj-user" },
  },
  {
    "kana/vim-textobj-indent",
    dependencies = { "kana/vim-textobj-user" },
  },
  {
    "junegunn/fzf",
    build = ":call fzf#install()",
  },
  {
    "junegunn/fzf.vim",
    dependencies = { "junegunn/fzf" },
  },

  -- Tree-sitter Support
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
  },
  { "nvim-treesitter/playground" },

  -- General Programming
  { "tpope/vim-commentary" },
  { "tpope/vim-fugitive" },

  -- Configuration Files
  { "fladson/vim-kitty" },

  -- Programming Languages
  { "elzr/vim-json" },
  { "leafgarland/typescript-vim" },
  { "kchmck/vim-coffee-script" },

  { "fatih/vim-go" },

  { "rust-lang/rust.vim" },

  { "derekwyatt/vim-scala" },
  { "derekwyatt/vim-sbt" },

  -- Markup Languages
  { "tpope/vim-markdown" },
  { "kpitt/vim-liquid" },
  { "mattn/emmet-vim" },

  -- Miscellaneous
  { "davidoc/taskpaper.vim" },
  { "PProvost/vim-ps1" },
}
