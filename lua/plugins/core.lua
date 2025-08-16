return {
  -- LazyVim core configuration
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-night",
    },
  },

  -- Tokyo Night colorscheme
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      terminal_colors = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      on_highlights = function(hl, c)
        -- Transparency fixes
        hl.Normal = { bg = "NONE" }
        hl.NormalFloat = { bg = "NONE" }
        hl.NormalNC = { bg = "NONE" }
        hl.SignColumn = { bg = "NONE" }

        -- Dashboard visibility fixes
        hl.MiniStarterHeader = { fg = "#7aa2f7", bold = true }
        hl.MiniStarterSection = { fg = "#c0caf5" }
        hl.MiniStarterItem = { fg = "#a9b1d6" }
        hl.MiniStarterItemBullet = { fg = "#7aa2f7" }
        hl.MiniStarterItemPrefix = { fg = "#e0af68" }
        hl.MiniStarterQuery = { fg = "#9ece6a" }
        hl.MiniStarterCurrent = { fg = "#ff9e64", bold = true }
        hl.MiniStarterFooter = { fg = "#565f89" }

        -- Alpha dashboard fallback
        hl.AlphaHeader = { fg = "#7aa2f7", bold = true }
        hl.AlphaButtons = { fg = "#a9b1d6" }
        hl.AlphaShortcut = { fg = "#ff9e64" }
        hl.AlphaFooter = { fg = "#565f89" }

        -- Status line
        hl.StatusLine = { fg = c.fg, bg = c.bg_dark }
        hl.StatusLineNC = { fg = c.fg_dark, bg = c.bg_dark }
      end,
    },
  },
}
