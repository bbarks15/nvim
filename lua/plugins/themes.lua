return {
  {
    "embark-theme/vim",
    name = "embark",
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
      variant = "dawn",
    }
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "latte",
      highlight_overrides = {
        mocha = function(_)
          return {
            CursorLineNr = { bg = "#2a2b3c" },
            CursorLineSign = { bg = "#2a2b3c" },
          }
        end,
        latte = function(colors)
          return {
            CursorLineNr = { bg = "#e9ebf1" },
            CursorLineSign = { bg = "#e9ebf1" },
            NormalFloat = { bg = colors.base },
          }
        end,
      },
    }
  },
  {
    "jesseleite/nvim-noirbuddy",
    dependencies = { "tjdevries/colorbuddy.nvim" },
  },
  "rebelot/kanagawa.nvim",
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      on_highlights = function(hl, c)
        hl.CursorLineNr = {
          bg = c.bg_highlight,
        }
      end,
    },
  },
  "nyoom-engineering/oxocarbon.nvim",
  {
    "zootedb0t/citruszest.nvim",
    lazy = false,
    -- priority = 1000,
    -- config = function()
    --   vim.cmd("colorscheme citruszest")
    -- end,
  },
}
