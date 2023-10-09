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
    name = "catppuccin",
    priority = 1000,
    config = function()
      require('catppuccin').setup({
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
      })
    end
  },
  {
    "jesseleite/nvim-noirbuddy",
    dependencies = { "tjdevries/colorbuddy.nvim" },
  },
  "rebelot/kanagawa.nvim",
  "folke/tokyonight.nvim",
  "EdenEast/nightfox.nvim",
  "olivercederborg/poimandres.nvim",
}
