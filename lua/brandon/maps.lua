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

keymap.set('x', '<leader>p', '"_dP')

keymap.set({'n', 'v'}, '<leader>y', '"+y')
keymap.set('n', '<leader>Y', 'gg"+yG')

keymap.set({'n','v'}, '<leader>d', '"_d')

keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
