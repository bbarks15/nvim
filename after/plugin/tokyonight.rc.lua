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
