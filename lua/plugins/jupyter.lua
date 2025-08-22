return {
  {
    "Vigemus/iron.nvim",
    lazy = false,
    config = function()
      local iron = require("iron.core")

      -- Simple setup: always use ipython
      iron.setup({
        config = {
          scratch_repl = true,
          repl_definition = {
            python = { command = { "ipython" } },
          },
          repl_open_cmd = "vertical botright 80 split",
        },
      })

      -------------------------------------------------------------------
      -- Helpers for Jupyter-style workflow
      -------------------------------------------------------------------

      local function send_cell()
        local start_line, end_line = nil, nil
        local cur_line = vim.fn.line(".")

        for l = cur_line, 1, -1 do
          if vim.fn.getline(l):match("^# %%") then
            start_line = l + 1
            break
          end
        end
        if not start_line then
          start_line = 1
        end

        local last = vim.fn.line("$")
        for l = cur_line + 1, last do
          if vim.fn.getline(l):match("^# %%") then
            end_line = l - 1
            break
          end
        end
        if not end_line then
          end_line = last
        end

        iron.send("python", vim.fn.getline(start_line, end_line))
      end

      local function send_cell_and_next()
        send_cell()
        local cur = vim.fn.line(".")
        local last = vim.fn.line("$")
        for l = cur + 1, last do
          if vim.fn.getline(l):match("^# %%") then
            vim.api.nvim_win_set_cursor(0, { l + 1, 0 })
            return
          end
        end
        vim.api.nvim_win_set_cursor(0, { last, 0 })
      end

      -------------------------------------------------------------------
      -- Keymaps
      -------------------------------------------------------------------
      vim.keymap.set("n", "<leader>rr", "<cmd>IronRepl<cr>", { desc = "Start REPL" })
      vim.keymap.set("n", "<leader>rc", send_cell, { desc = "Send Cell (#%%)" })
      vim.keymap.set("n", "<leader>rn", send_cell_and_next, { desc = "Send Cell + Next" })
      vim.keymap.set("n", "<leader>rl", iron.send_line, { desc = "Send Line" })
      vim.keymap.set("v", "<leader>rs", iron.visual_send, { desc = "Send Selection" })
      vim.keymap.set("n", "<leader>rf", iron.send_file, { desc = "Send File" })
      vim.keymap.set("n", "<leader>ro", iron.clear, { desc = "Clear REPL" })
      vim.keymap.set("n", "<leader>rq", iron.exit, { desc = "Quit REPL" })
    end,
  },
}
