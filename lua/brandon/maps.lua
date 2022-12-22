local keymap = vim.keymap

vim.g.mapleader = " "

keymap.set("n", "<leader>pv", vim.cmd.Ex)

keymap.set('n', 'x', '"_x')

-- Increment/decrement
keymap.set('n', '+', '<C-a>')
keymap.set('n', '-', '<C-x>')

-- Select all
keymap.set('n', '<leader>a', 'gg<S-v>G')

-- Save
keymap.set('n', '<C-s>', '<cmd>w<cr>')

-- Resize window
keymap.set('n', '<leader><left>', '<C-w><')
keymap.set('n', '<leader><right>', '<C-w>>')
keymap.set('n', '<leader><up>', '<C-w>+')
keymap.set('n', '<leader><down>', '<C-w>-')

keymap.set('v', '<leader>p', '"_dP')

keymap.set('n', '<leader>y', '"+y')
keymap.set('v', '<leader>y', '"+y')
keymap.set('n', '<leader>Y', 'gg"+yG')


keymap.set('v', '<leader>d', '"_d')
keymap.set('n', '<leader>d', '"_d')
