local status, ih = pcall(require, "inlay-hints")
if (not status) then return end

-- ih.setup({
--   only_current_line = false,
--   hints = {
--     parameter = {
--       show = true,
--       highlight = "Comment",
--     },
--     type = {
--       show = true,
--       highlight = "Comment",
--     },
--   },
-- })
