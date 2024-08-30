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
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
      opt.showmode = false  -- only show mode in the lualine status bar

      require("lualine").setup({
        sections = {
          lualine_c = { { "filename", path = 1 } },
          lualine_x = {
            {
              "encoding",
              separator = "",
              padding = { right = 0 },
            },
            {
              "fileformat",
              symbols = {
                -- use text instead of icons
                unix = "[unix]",
                dos = "[dos]",
                mac = "[mac]",
              },
            },
            "filetype",
          },
        },
        tabline = {
          lualine_a = {
            {
              "buffers",
              icons_enabled = false,
              show_filename_only = false,
            },
          },
          lualine_z = {
            {
              "tabs",
              show_modified_status = false,
            },
          }
        },
        extensions = { "fugitive", "quickfix", "fzf", "lazy" },
      })
    end,
  },

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
