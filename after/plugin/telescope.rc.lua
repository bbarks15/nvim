local status, telescope = pcall(require, "telescope")
if (not status) then return end

local actions = require('telescope.actions')
local builtin = require("telescope.builtin")

local function get_pickers(a)
  return {
    find_files = {
      theme = "dropdown",
      hidden = true,
      previewer = false,
    },
    buffers = {
      theme = "dropdown",
      previewer = false,
      initial_mode = "normal",
      mappings = {
        i = { ["<C-d>"] = a.delete_buffer, },
        n = { ["dd"] = a.delete_buffer, },
      },
    },
    git_files = {
      theme = "dropdown",
      hidden = true,
      previewer = false,
      show_untracked = true,
    },
  }
end

telescope.setup {
  defaults = {
    mappings = {
      n = { ["q"] = actions.close },
    },
    pickers = get_pickers(actions),
    file_ignore_patterns = { "^.git", "^obj", "^bin", "^node_modules", "^.next", "^.idea", "^.vscode" },
  },
  pickers = get_pickers(actions),
  extensions = {},
}

telescope.load_extension("fzf")

vim.keymap.set('n', '<C-P>', function() builtin.find_files({ hidden = true }) end)
vim.keymap.set('n', '<leader>F', function() builtin.live_grep() end)
vim.keymap.set('n', '<leader>r', function() builtin.oldfiles() end)
vim.keymap.set('n', '<leader>b', function() builtin.buffers() end)
vim.keymap.set('n', '<leader><leader>', function() builtin.resume() end)
vim.keymap.set('n', '<leader>s', function() builtin.lsp_document_symbols() end)
vim.keymap.set('n', '<leader>S', function() builtin.lsp_dynamic_workspace_symbols() end)
