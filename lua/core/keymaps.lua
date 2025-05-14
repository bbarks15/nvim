local map = require("helpers.keys").map

map('n', 'x', '"_x')

map('x', '<leader>p', '"_dP')

map({'n', 'v'}, '<leader>y', '"+y')
map('n', '<leader>Y', 'gg"+yG')

map({'n','v'}, '<leader>d', '"_d')

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
