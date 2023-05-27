local status, tree = pcall(require, "nvim-tree")
if (not status) then return end

-- empty setup using defaults
tree.setup({
  view = {
    signcolumn = "no",
  },
  renderer = {
    root_folder_label = false,
  }
})

vim.keymap.set("n", "<leader>e", "<CMD>NvimTreeToggle<CR>")
vim.keymap.set("n", "<leader>E", "<CMD>NvimTreeFindFile<CR>")

-- -- OR setup with some options
-- require("nvim-tree").setup({
--   sort_by = "case_sensitive",
--   renderer = {
--     group_empty = true,
--   },
--   filters = {
--     dotfiles = true,
--   },
-- })
