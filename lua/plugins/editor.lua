return {
  -- Treesitter configuration
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "python",
        "lua",
        "vim",
        "javascript",
        "typescript",
        "json",
        "markdown",
        "html",
        "css",
        "bash",
        "yaml",
      },
    },
  },

  -- Telescope with better defaults
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = {
          prompt_position = "top",
          width = 0.9,
          height = 0.8,
        },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },

  -- Enhanced line movement
  {
    "fedepujol/move.nvim",
    keys = {
      { "<A-j>", ":MoveLine(1)<CR>", desc = "Move line down", mode = "n" },
      { "<A-k>", ":MoveLine(-1)<CR>", desc = "Move line up", mode = "n" },
      { "<A-j>", ":MoveBlock(1)<CR>", desc = "Move block down", mode = "v" },
      { "<A-k>", ":MoveBlock(-1)<CR>", desc = "Move block up", mode = "v" },
    },
    opts = {
      line = { enable = true, indent = true },
      block = { enable = true, indent = true },
      word = { enable = true },
      char = { enable = false },
    },
  },
}
