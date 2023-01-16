local status, ih = pcall(require, "inlay-hints")
if (not status) then return end

ih.setup({
  renderer = "inlay-hints.render.eol",
  only_current_line = false,
  hints = {
    parameter = { show = false, },
    type = {
      show = true,
      highlight = "Comment",
    },
  },
})
