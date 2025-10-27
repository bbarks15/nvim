return {
  {
    "embark-theme/vim",
    lazy = true,
    name = "embark",
  },
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
    -- lazy = true,
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
            -- NormalFloat = { bg = colors.base },
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
    opts = {
      transparent = true
    }
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "day",
      day_brightness = 0.35
      -- transparent = true,
      -- on_highlights = function(hl, c)
      --   hl.CursorLineNr = {
      --     bg = c.bg_highlight,
      --   }
      -- end,
    },
  },
  {
    "nyoom-engineering/oxocarbon.nvim",
    -- lazy = true,
  },
  {
    "zootedb0t/citruszest.nvim",
    lazy = true,
    opts = {}
    -- priority = 1000,
    -- config = function()
    --   vim.cmd("colorscheme citruszest")
    -- end,
  },
  {
    "dgox16/oldworld.nvim",
    -- lazy = true,
    -- priority = 1000,
  },
  {
    "oxfist/night-owl.nvim",
    lazy = true, -- make sure we load this during startup if it is your main colorscheme
    -- priority = 1000, -- make sure to load this before all the other start plugins
    -- config = function()
    -- 	-- load the colorscheme here
    -- 	require("night-owl").setup()
    -- 	vim.cmd.colorscheme("night-owl")
    -- end,
  },
  'Yazeed1s/oh-lucy.nvim',
  "navarasu/onedark.nvim",
  -- "olimorris/onedarkpro.nvim",
}
