require('impatient')

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('brandon.base')
require('brandon.highlights')
require('brandon.maps')
require('brandon.plugins')

local has = vim.fn.has
local is_mac = has "macunix"
local is_win = has "win32"

if is_mac then
  require('brandon.macos')
end
if is_win then
  require('brandon.windows')
end

local augroup = vim.api.nvim_create_augroup
local yank_group = augroup('HighlightYank', {})
local BrandonGroup = augroup('Brandon', {})

local autocmd = vim.api.nvim_create_autocmd

autocmd('TextYankPost', {
  group = yank_group,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',
      timeout = 100,
    })
  end,
})

autocmd({ "BufWritePre" }, {
  group = BrandonGroup,
  pattern = "*",
  command = "%s/\\s\\+$//e",
})
