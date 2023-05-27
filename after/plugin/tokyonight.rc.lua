local status, tokyo = pcall(require, "tokyonight")
if (not status) then return end

tokyo.setup({
  style = "moon",
  on_highlights = function(hl, c)
    hl.CursorLineNr = {
      bg = c.bg_highlight,
    }
  end,
})

require("catppuccin").setup {
  flavour = "mocha",
  highlight_overrides = {
    mocha = function(mocha)
      return {
        CursorLineNr = { bg = "#2a2b3c" },
        CursorLineSign = { bg = "#2a2b3c" },
      }
    end,
  },
}

vim.cmd.colorscheme "catppuccin"
