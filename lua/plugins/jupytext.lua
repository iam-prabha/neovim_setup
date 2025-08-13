-- File: ~/.config/nvim/lua/plugins/jupytext.lua
return {
  "GCBallesteros/jupytext.nvim",
  lazy = false, -- Force it to load immediately on startup
  config = function()
    require("jupytext").setup()
  end,
  keys = {
    -- Keymaps for running cells and navigating
    { "<leader>jo", "<cmd>JupytextOpen<cr>", desc = "Open Jupytext Notebook" },
    { "<leader>jr", "<cmd>JupytextRunCell<cr>", desc = "Run Current Cell" },
    { "<leader>jR", "<cmd>JupytextRunAll<cr>", desc = "Run All Cells" },
    { "<leader>jc", "<cmd>JupytextClearOutputs<cr>", desc = "Clear Cell Outputs" },
    { "<leader>jn", "<cmd>JupytextGoNextCell<cr>", desc = "Go to Next Cell" },
    { "<leader>jp", "<cmd>JupytextGoPrevCell<cr>", desc = "Go to Previous Cell" },
    -- Visual mode keymap to run a selection of code
    {
      "<leader>js",
      "<esc>:JupytextRunSelection<cr>",
      mode = "v",
      desc = "Run Selected Lines",
    },
  },
}
