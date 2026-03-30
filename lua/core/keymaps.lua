vim.keymap.set('n', 'x', '"_x', { silent = true, desc = "Delete char without yank" })

vim.keymap.set('x', '<leader>p', '"_dP', { silent = true, desc = "Paste without yank" })

vim.keymap.set({ 'n', 'v' }, '<leader>d', '"_d', { silent = true, desc = "Delete without yank" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move selection up" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { silent = true, desc = "Scroll down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { silent = true, desc = "Scroll up and center" })
