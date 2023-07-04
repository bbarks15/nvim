local status, catppuccin = pcall(require, "catppuccin")
if (not status) then return end

catppuccin.setup {
  flavour = "latte",
  highlight_overrides = {
    mocha = function(mocha)
      return {
        CursorLineNr = { bg = "#2a2b3c" },
        CursorLineSign = { bg = "#2a2b3c" },
      }
    end,
    latte = function(latte)
      return {
        CursorLineNr = { bg = "#e9ebf1" },
        CursorLineSign = { bg = "#e9ebf1" },
      }
    end,
  },
}

vim.cmd.colorscheme "catppuccin"
