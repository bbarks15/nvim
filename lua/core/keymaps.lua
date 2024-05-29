local map = require("helpers.keys").map

map("n", "<leader>pv", vim.cmd.Ex)

map('n', 'x', '"_x')

-- Increment/decrement
map('n', '+', '<C-a>')
map('n', '-', '<C-x>')

-- Save
map('n', '<C-s>', '<cmd>w<cr>')

map('x', '<leader>p', '"_dP')

map({'n', 'v'}, '<leader>y', '"+y')
map('n', '<leader>Y', 'gg"+yG')

map({'n','v'}, '<leader>d', '"_d')

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

map("n", "<C-k>", "<cmd>cprev<CR>zz")
map("n", "<C-j>", "<cmd>cnext<CR>zz")
map("n", "<leader>k", "<cmd>lnext<CR>zz")
map("n", "<leader>j", "<cmd>lprev<CR>zz")

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
