local status, lazygit = pcall(require, "lazygit")
if (not status) then return end

vim.keymap.set('n', '<leader>G', "<CMD>LazyGit<CR>")
