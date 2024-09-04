local opt = vim.opt
local g   = vim.g

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local chezmoi_source = os.getenv("HOME") .. "/.dotfiles"

local fzf_chezmoi = function()
  local fzf_lua = require("fzf-lua")
  local chezmoi = require("chezmoi.commands")
  local results = chezmoi.list({ args = {"--include=files"} })

  local opts = {
    fzf_opts = {},
    fzf_colors = true,
    actions = {
      ["default"] = function(selected)
        chezmoi.edit({
          targets = { "~/" .. selected[1] },
          args = { "--watch" },
        })
      end,
    },
  }
  fzf_lua.fzf_exec(results, opts)
end

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

      local iceberg = require("config.lualine.iceberg")
      require("lualine").setup({
        options = {
          theme = iceberg.theme,
          globalstatus = true,
        },
        sections = {
          lualine_b = {
            { "branch", draw_empty = true },
            {
              "diff",
              source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
            },
            "diagnostics",
          },
          lualine_c = { { "filename", path = 1 } },
          lualine_x = {
            {
              "encoding",
              separator = "",
              padding = { right = 0 },
              cond = function()
                return vim.o.fileencoding ~= "utf-8"
              end,
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
            { "filetype", color = { fg = iceberg.colors.gradient_fg } },
          },
          lualine_y = {
            { "progress", color = { fg = iceberg.colors.hilite_fg } },
          },
        },
        tabline = {
          lualine_a = {
            {
              "buffers",
              icons_enabled = false,
              show_filename_only = false,
              fmt = function(n)
                -- Replace HOME directory with ~
                -- Note that name has already been shortened before calling `fmt`
                local home = vim.fn.fnamemodify(os.getenv("HOME"), ":p")
                local short_home = vim.fn.pathshorten(home)
                return n:gsub("^" .. short_home, "~/")
              end,
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

  -- highlighting and handling of chezmoi-managed dot-files and templates
  {
    "alker0/chezmoi.vim",
    lazy = false,
    init = function()
      vim.g["chezmoi#use_tmp_buffer"] = 1
      vim.g["chezmoi#source_dir_path"] = chezmoi_source
    end,
  },
  {
    "xvzc/chezmoi.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    keys = {
      { "<leader>fz", fzf_chezmoi, desc = "Chezmoi" },
    },
    init = function()
      -- run chezmoi edit on file enter
      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = { chezmoi_source .. "/*" },
        callback = function(ev)
          local win_id = vim.api.nvim_get_current_win()
          local bufnr = ev.buf
          local edit_watch = function()
            -- diff mode usually indicates a `chezmoi merge`, so don't auto-apply
            local diff_opt = vim.api.nvim_get_option_value("diff", { win = win_id })
            if not diff_opt then
              require("chezmoi.commands.__edit").watch(bufnr)
            end
          end
          vim.schedule(edit_watch)
        end,
      })
    end,
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
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "FzfLua",
    opts = function(_, opts)
      local actions = require("fzf-lua.actions")

      local defaults = require("fzf-lua.profiles.default-title")
      -- use the same prompt for all
      local function fix(t)
        t.prompt = t.prompt ~= nil and " " or nil
        for _, v in pairs(t) do
          if type(v) == "table" then
            fix(v)
          end
        end
      end
      fix(defaults)

      return vim.tbl_deep_extend("force", defaults, {
        fzf_colors = true,
        fzf_opts = {
          ["--no-scrollbar"] = true,
        },
        defaults = {
          formatter = "path.dirname_first",
        },
        winopts = {
          width = 0.8,
          height = 0.8,
          row = 0.5,
          col = 0.5,
          preview = {
            scrollchars = { "┃", "" },
          },
        },
        files = {
          cwd_prompt = false,
          actions = {
            ["alt-i"] = { actions.toggle_ignore },
            ["alt-h"] = { actions.toggle_hidden },
          },
        },
        grep = {
          actions = {
            ["alt-i"] = { actions.toggle_ignore },
            ["alt-h"] = { actions.toggle_hidden },
          },
        },
        lsp = {
          code_actions = {
            previewer = "codeaction_native",
          },
        },
      })
    end,
    config = function(_, opts)
      local fzf_lua = require("fzf-lua")
      fzf_lua.setup(opts)
      -- Use `fzf-lua` as the `vim.ui.select` picker
      fzf_lua.register_ui_select()
    end,
    keys = {
      { "<c-p>", "<cmd>FzfLua files<cr>", desc = "Find Files" },
      {
        "<c-\\>",
        "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>",
        desc = "Switch Buffer",
      },
      { "<F1>", "<cmd>FzfLua help_tags<cr>", desc = "Help Pages" },
      {
        "<leader>,",
        "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>",
        desc = "Switch Buffer",
      },
      { "<leader>/", "<cmd>FzfLua live_grep<cr>", desc = "Grep" },
      { "<leader>:", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
      { "<leader><space>", "<cmd>FzfLua files<cr>", desc = "Find Files" },
      -- find
      { "<leader>fb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
      {
        "<leader>fc",
        function()
          require("fzf-lua").files({ cwd = vim.fn.stdpath("config") })
        end,
        desc = "Find Config File",
      },
      { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find Files" },
      { "<leader>fg", "<cmd>FzfLua git_files<cr>", desc = "Find Files (git-files)" },
      { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent" },
      -- git
      { "<leader>gc", "<cmd>FzfLua git_commits<CR>", desc = "Commits" },
      { "<leader>gs", "<cmd>FzfLua git_status<CR>", desc = "Status" },
      -- search
      { "<leader>sc", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
      { "<leader>sC", "<cmd>FzfLua commands<cr>", desc = "Commands" },
      { "<leader>sh", "<cmd>FzfLua help_tags<cr>", desc = "Help Pages" },
      { "<leader>sk", "<cmd>FzfLua keymaps<cr>", desc = "Key Maps" },
      { "<leader>sR", "<cmd>FzfLua resume<cr>", desc = "Resume" },
      { "<leader>sq", "<cmd>FzfLua quickfix<cr>", desc = "Quickfix List" },
    },
  },

  -- which-key shows a popup to help with remembering key bindings
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      delay = function(ctx)
        return ctx.plugin and 0 or 500
      end,
      spec = {
        {
          mode = { "n", "v" },
          { "<leader>f", group = "file/find" },
          { "<leader>g", group = "git" },
          { "<leader>s", group = "search" },
          { "[", group = "prev" },
          { "]", group = "next" },
          { "g", group = "goto" },
          { "z", group = "fold" },
          -- better descriptions
          { "gx", desc = "Open with system app" },
        },
      },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
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
  {
    "lewis6991/gitsigns.nvim",
    event = "LazyFile",
    opts = {},
  },

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
