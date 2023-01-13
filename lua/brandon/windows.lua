vim.opt.clipboard:prepend { 'unnamed', 'unnamedplus' }

function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('n', '<C-z>', '<nop>')
map('i', '<C-z>', '<nop>')
map('v', '<C-z>', '<nop>')
map('s', '<C-z>', '<nop>')
map('x', '<C-z>', '<nop>')
map('c', '<C-z>', '<nop>')
map('o', '<C-z>', '<nop>')
