return {
  "NeogitOrg/neogit",
  cmd = "Neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim", -- diff integration

    -- Enable only one of these, depending on the default picker.
    -- "nvim-telescope/telescope.nvim", -- optional
    -- "ibhagwan/fzf-lua",              -- optional
    -- "echasnovski/mini.pick",         -- optional
    "folke/snacks.nvim", -- optional
  },
  keys = {
    { "<leader>gN", "<cmd>Neogit<cr>", desc = "Neogit" },
  },
}
