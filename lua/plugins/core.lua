-- LazyVim plugin configuration
-- This file will be loaded automatically by lazy.nvim

return {
  -- Add Tokyo Night colorscheme
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true, -- Enable transparent background
      terminal_colors = true,
      styles = {
        sidebars = "transparent", -- Make sidebars transparent too
        floats = "transparent", -- Make floating windows transparent
      },
      on_highlights = function(hl, c)
        -- Make sure normal background is truly transparent
        hl.Normal = { bg = "NONE" }
        hl.NormalFloat = { bg = "NONE" }
        hl.NormalNC = { bg = "NONE" }
        hl.SignColumn = { bg = "NONE" }

        -- Fix Mini Starter (dashboard) visibility with bright colors for transparency
        hl.MiniStarterHeader = { fg = "#7aa2f7", bold = true } -- Bright blue
        hl.MiniStarterSection = { fg = "#c0caf5" } -- Light foreground
        hl.MiniStarterItem = { fg = "#a9b1d6" } -- Slightly dimmer
        hl.MiniStarterItemBullet = { fg = "#7aa2f7" } -- Bright blue
        hl.MiniStarterItemPrefix = { fg = "#e0af68" } -- Bright yellow
        hl.MiniStarterQuery = { fg = "#9ece6a" } -- Bright green
        hl.MiniStarterCurrent = { fg = "#ff9e64", bold = true } -- Bright orange
        hl.MiniStarterFooter = { fg = "#565f89" } -- Dim for footer

        -- Also set Alpha highlights in case they're used
        hl.AlphaHeader = { fg = "#7aa2f7", bold = true }
        hl.AlphaButtons = { fg = "#a9b1d6" }
        hl.AlphaShortcut = { fg = "#ff9e64" }
        hl.AlphaFooter = { fg = "#565f89" }

        -- Keep some elements visible but with minimal background
        hl.StatusLine = { fg = c.fg, bg = c.bg_dark }
        hl.StatusLineNC = { fg = c.fg_dark, bg = c.bg_dark }
      end,
    },
  },

  -- Configure LazyVim to use Tokyo Night
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-night", -- Options: tokyonight-night, tokyonight-storm, tokyonight-day, tokyonight-moon
    },
  },

  -- Python LSP with automatic environment detection
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          settings = {
            python = {
              -- Auto-detect Python path with conda as fallback preference
              pythonPath = function()
                -- First check for conda environment (preferred fallback)
                local conda_prefix = vim.fn.getenv("CONDA_PREFIX")
                if conda_prefix and conda_prefix ~= vim.NIL then
                  local conda_python = conda_prefix .. "/bin/python"
                  if vim.fn.executable(conda_python) == 1 then
                    return conda_python
                  end
                end

                -- Check for virtual environment
                local venv_python = vim.fn.executable("python") == 1 and vim.fn.exepath("python") or nil
                if venv_python and (venv_python:find("/.venv/") or venv_python:find("/venv/")) then
                  return venv_python
                end

                -- Check for conda base installation if no active environment
                local conda_base = vim.fn.expand("~/anaconda/bin/python")
                if vim.fn.executable(conda_base) == 1 then
                  return conda_base
                end

                return vim.fn.exepath("python3") or vim.fn.exepath("python")
              end,
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

  -- Essential treesitter parsers
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

  -- Essential tools via Mason
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- Python tools
        "pyright", -- Python LSP
        "black", -- Python formatter
        "isort", -- Import sorter
        "flake8", -- Python linter

        -- General tools
        "lua-language-server",
        "stylua", -- Lua formatter
        "prettier", -- JS/TS/JSON formatter

        -- Git tools
        "commitlint", -- Commit message linting
        "gitlint", -- Git commit linting
      },
    },
  },

  -- Better Python formatting
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
        winblend = 0, -- No transparency for telescope
      },
    },
  },

  -- Auto-detect Python virtual environments with conda preference
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
    opts = {
      name = {
        "venv",
        ".venv",
        "env",
        ".env",
      },
      auto_refresh = true,
      anaconda_base_path = "~/anaconda",
      anaconda_envs_path = "~/anaconda/envs",
      -- Show conda environments prominently
      search_venv_managers = true,
      search_workspace = true,
    },
    keys = {
      { "<leader>cv", "<cmd>VenvSelect<cr>", desc = "Select Python Environment" },
      { "<leader>cc", "<cmd>VenvSelectCached<cr>", desc = "Select Cached Python Environment" },
    },
  },

  -- Language extras (uncomment what you need)
  { import = "lazyvim.plugins.extras.lang.python" },
  { import = "lazyvim.plugins.extras.lang.json" },
  -- { import = "lazyvim.plugins.extras.lang.typescript" },
  -- { import = "lazyvim.plugins.extras.lang.docker" },

  -- GitHub Copilot integration
  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      -- Copilot settings
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_tab_fallback = ""

      -- Custom keymaps for Copilot
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

  -- Alternative: Copilot Chat for AI assistance
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

  -- Enhanced Git integration with Lazygit
  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "Open LazyGit" },
    },
  },

  -- Better Git signs and hunks
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      current_line_blame = true, -- Show git blame on current line
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 300,
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- Navigation
        map("n", "]h", gs.next_hunk, "Next Hunk")
        map("n", "[h", gs.prev_hunk, "Prev Hunk")

        -- Actions
        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>ghb", function()
          gs.blame_line({ full = true })
        end, "Blame Line")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function()
          gs.diffthis("~")
        end, "Diff This ~")

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    },
  },

  -- Git blame and history
  {
    "f-person/git-blame.nvim",
    opts = {
      enabled = false, -- Start disabled, toggle with command
      message_template = " <summary> • <date> • <author>",
      date_format = "%m-%d-%Y %H:%M:%S",
      virtual_text_column = 1,
    },
    keys = {
      { "<leader>gb", "<cmd>GitBlameToggle<cr>", desc = "Toggle Git Blame" },
    },
  },

  -- Git diff view
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
      { "<leader>gh", "<cmd>DiffviewFileHistory<cr>", desc = "File History" },
      { "<leader>gc", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
    },
  },

  -- Dashboard with Alpha (LazyVim default) - better transparency support
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      local logo = [[
██╗      █████╗ ███████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗
██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║
██║     ███████║  ███╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║
██║     ██╔══██║ ███╔╝    ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║
███████╗██║  ██║███████╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║
╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝
      ]]

      dashboard.section.header.val = vim.split(logo, "\n")
      dashboard.section.buttons.val = {
        dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
        dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
        dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
        dashboard.button("c", "  Configuration", ":e $MYVIMRC <CR>"),
        dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
      }

      local function footer()
        return "Don't Stop Until You are Proud..."
      end

      dashboard.section.footer.val = footer()

      dashboard.section.footer.opts.hl = "Type"
      dashboard.section.header.opts.hl = "AlphaHeader"
      dashboard.section.buttons.opts.hl = "AlphaButtons"

      dashboard.opts.opts.noautocmd = true
      return dashboard
    end,
    config = function(_, dashboard)
      -- Close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "AlphaReady",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      require("alpha").setup(dashboard.opts)

      -- Set custom highlights for transparency
      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          vim.api.nvim_set_hl(0, "AlphaHeader", { fg = "#7aa2f7", bold = true })
          vim.api.nvim_set_hl(0, "AlphaButtons", { fg = "#a9b1d6" })
          vim.api.nvim_set_hl(0, "AlphaShortcut", { fg = "#ff9e64" })
          vim.api.nvim_set_hl(0, "AlphaFooter", { fg = "#565f89" })
        end,
      })
    end,
  },
}
