return {
  -- Toggle Terminal with multiple modes
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<C-\>]],
      hide_numbers = true,
      shade_terminals = false,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      direction = "float",
      close_on_exit = true,
      shell = vim.o.shell,
      auto_scroll = true,
      float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
        width = function()
          return math.ceil(vim.o.columns * 0.8)
        end,
        height = function()
          return math.ceil(vim.o.lines * 0.8)
        end,
      },
      winbar = { enabled = false },
    },
    keys = {
      { "<C-\\>", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal", mode = { "n", "t" } },
      { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Toggle Floating Terminal" },
      { "<leader>th", "<cmd>ToggleTerm size=15 direction=horizontal<cr>", desc = "Toggle Horizontal Terminal" },
      { "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "Toggle Vertical Terminal" },
      { "<leader>t1", "<cmd>1ToggleTerm<cr>", desc = "Toggle Terminal 1" },
      { "<leader>t2", "<cmd>2ToggleTerm<cr>", desc = "Toggle Terminal 2" },
      { "<leader>t3", "<cmd>3ToggleTerm<cr>", desc = "Toggle Terminal 3" },
      { "<C-h>", "<cmd>wincmd h<cr>", desc = "Go to left window", mode = "t" },
      { "<C-j>", "<cmd>wincmd j<cr>", desc = "Go to lower window", mode = "t" },
      { "<C-k>", "<cmd>wincmd k<cr>", desc = "Go to upper window", mode = "t" },
      { "<C-l>", "<cmd>wincmd l<cr>", desc = "Go to right window", mode = "t" },
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)

      local Terminal = require("toggleterm.terminal").Terminal

      -- Lazygit integration
      local lazygit = Terminal:new({
        cmd = "lazygit",
        dir = "git_dir",
        direction = "float",
        float_opts = {
          border = "curved",
          width = function()
            return math.ceil(vim.o.columns * 0.9)
          end,
          height = function()
            return math.ceil(vim.o.lines * 0.9)
          end,
        },
        on_open = function(term)
          vim.cmd("startinsert!")
          vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
        end,
      })

      -- Python REPL
      local python = Terminal:new({
        cmd = "python3",
        direction = "float",
        float_opts = { border = "curved" },
      })

      -- Node REPL
      local node = Terminal:new({
        cmd = "node",
        direction = "float",
        float_opts = { border = "curved" },
      })

      -- Htop system monitor
      local htop = Terminal:new({
        cmd = "htop",
        direction = "float",
        float_opts = {
          border = "curved",
          width = function()
            return math.ceil(vim.o.columns * 0.9)
          end,
          height = function()
            return math.ceil(vim.o.lines * 0.9)
          end,
        },
      })

      -- Keymaps for custom terminals
      vim.keymap.set("n", "<leader>gg", function()
        lazygit:toggle()
      end, { desc = "LazyGit" })
      vim.keymap.set("n", "<leader>tp", function()
        python:toggle()
      end, { desc = "Python REPL" })
      vim.keymap.set("n", "<leader>tn", function()
        node:toggle()
      end, { desc = "Node REPL" })
      vim.keymap.set("n", "<leader>tt", function()
        htop:toggle()
      end, { desc = "Htop" })

      -- Better terminal keymaps
      function _G.set_terminal_keymaps()
        local opts = { buffer = 0 }
        vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
        vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
        vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
      end

      vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
    end,
  },
}
