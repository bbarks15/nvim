local status, lspkind = pcall(require, "lspkind")
if (not status) then return end

local icons = require('brandon.icons')

lspkind.init({
  mode = 'symbol',
  preset = 'default',
  symbol_map = icons.kind
})
