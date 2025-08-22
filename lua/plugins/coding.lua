return {
  -- Python LSP with conda support
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
              },
            },
          },
        },
      },
    },
  },

  -- Mason tool installer
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- Python tools
        "pyright",
        "black",
        "isort",
        "flake8",
        -- General tools
        "lua-language-server",
        "stylua",
        "prettier",
        -- Git tools
        "commitlint",
        "gitlint",
      },
    },
  },

  -- Code formatting
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "isort", "black" },
        lua = { "stylua" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        json = { "prettier" },
      },
    },
  },

  -- Python environment selector
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
    opts = {
      name = { "venv", ".venv", "env", ".env" },
      auto_refresh = true,
      anaconda_base_path = "~/anaconda",
      anaconda_envs_path = "~/anaconda/envs",
      search_venv_managers = true,
      search_workspace = true,
    },
    keys = {
      { "<leader>cv", "<cmd>VenvSelect<cr>", desc = "Select Python Environment" },
      { "<leader>cc", "<cmd>VenvSelectCached<cr>", desc = "Select Cached Python Environment" },
    },
  },

  -- GitHub Copilot
  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_tab_fallback = ""

      vim.keymap.set(
        "i",
        "<C-J>",
        'copilot#Accept("<CR>")',
        { silent = true, expr = true, desc = "Accept Copilot suggestion" }
      )
      vim.keymap.set("i", "<C-L>", "<Plug>(copilot-accept-word)", { desc = "Accept Copilot word" })
      vim.keymap.set("i", "<C-H>", "<Plug>(copilot-dismiss)", { desc = "Dismiss Copilot suggestion" })
      vim.keymap.set("i", "<C-N>", "<Plug>(copilot-next)", { desc = "Next Copilot suggestion" })
      vim.keymap.set("i", "<C-P>", "<Plug>(copilot-previous)", { desc = "Previous Copilot suggestion" })
    end,
  },

  -- Copilot Chat
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim" },
    },
    opts = {
      debug = false,
      show_help = false,
      prompts = {
        Explain = "Please explain how the following code works.",
        Review = "Please review the following code and provide suggestions for improvement.",
        Tests = "Please explain how the selected code works, then generate unit tests for it.",
        Refactor = "Please refactor the following code to improve its clarity and readability.",
        FixCode = "Please fix the following code to make it work as intended.",
        BetterNamings = "Please provide better names for the following variables and functions.",
        Documentation = "Please provide documentation for the following code.",
      },
    },
    keys = {
      { "<leader>cC", "<cmd>CopilotChat<cr>", desc = "Open Copilot Chat" },
      { "<leader>ce", "<cmd>CopilotChatExplain<cr>", mode = { "n", "v" }, desc = "Explain code" },
      { "<leader>cr", "<cmd>CopilotChatReview<cr>", mode = { "n", "v" }, desc = "Review code" },
      { "<leader>ct", "<cmd>CopilotChatTests<cr>", mode = { "n", "v" }, desc = "Generate tests" },
      { "<leader>cf", "<cmd>CopilotChatFixCode<cr>", mode = { "n", "v" }, desc = "Fix code" },
      { "<leader>cd", "<cmd>CopilotChatDocumentation<cr>", mode = { "n", "v" }, desc = "Generate docs" },
    },
  },
}
