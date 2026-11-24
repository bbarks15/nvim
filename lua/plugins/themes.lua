return {
  {
    "rose-pine/neovim",
    lazy = true,
    name = "rose-pine",
    opts = {
      variant = "dawn",
      dim_inactive_windows = false,
    }
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      transparent_background = true,
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
    }
  },
  {
    "jesseleite/nvim-noirbuddy",
    lazy = true,
    dependencies = { "tjdevries/colorbuddy.nvim" },
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    opts = {
      transparent = true
    }
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      style = "day",
      -- day_brightness = 0.35,
      transparent = true,
      lualine_bold = true,
      on_highlights = function(hl, c)
        -- drop the inline-code background box (keep the blue fg)
        hl["@markup.raw.markdown_inline"].bg = "NONE"
        -- drop the heading background bands (keep per-level rainbow fg + bold)
        for i = 1, 6 do
          local g = hl["@markup.heading." .. i .. ".markdown"]
          if g then g.bg = "NONE" end
        end
      end,
    },
  },
  {
    "zootedb0t/citruszest.nvim",
    lazy = true,
    opts = {},
  },
  {
    "dgox16/oldworld.nvim",
    lazy = true,
  },
  {
    "oxfist/night-owl.nvim",
    lazy = true,
  },
  { 'Yazeed1s/oh-lucy.nvim', lazy = true },
  { "navarasu/onedark.nvim", lazy = true },
  {
    dir = "/Users/brandon/development/embark.nvim",
    lazy = true,
    opts = {
      transparent = true,
      on_colors = function(colors)
        colors.bg, colors.bg_dark = colors.bg_dark, colors.bg
      end,
    }
  }
}
