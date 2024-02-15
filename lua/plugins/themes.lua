-- Themes
return {
  {
    "embark-theme/vim",
    name = "embark",
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
  },

  {
    "catppuccin/nvim",
    -- dependencies = {
    --   "nvim-neo-tree/neo-tree.nvim",
    -- },
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
        latte = function(_)
          return {
            CursorLineNr = { bg = "#e9ebf1" },
            CursorLineSign = { bg = "#e9ebf1" },
          }
        end,
      },
      integrations = {
        neotree = true,
      }
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
  "olivercederborg/poimandres.nvim",
  "zootedb0t/citruszest.nvim",
}
