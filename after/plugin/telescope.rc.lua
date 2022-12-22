local status, telescope = pcall(require, "telescope")
if (not status) then return end
local actions = require('telescope.actions')
local builtin = require("telescope.builtin")

local function telescope_buffer_dir()
  return vim.fn.expand('%:p:h')
end

local fb_actions = require "telescope".extensions.file_browser.actions

telescope.setup {
  defaults = {
    mappings = {
      n = {
        ["q"] = actions.close
      },
    },
    file_ignore_patterns = { "^.git", "^obj", "^bin", "^node_modules", "^.next", "^.idea", "^.vscode" },
  },
  extensions = {
    -- file_browser = {
    --   theme = "dropdown",
    --   -- disables netrw and use telescope-file-browser in its place
    --   hijack_netrw = true,
    --   mappings = {
    --     -- your custom insert mode mappings
    --     ["i"] = {
    --       ["<C-w>"] = function() vim.cmd('normal vbd') end,
    --     },
    --     ["n"] = {
    --       -- your custom normal mode mappings
    --       ["N"] = fb_actions.create,
    --       ["h"] = fb_actions.goto_parent_dir,
    --       ["/"] = function()
    --         vim.cmd('startinsert')
    --       end
    --     },
    --   },
    -- },
  },
}

telescope.load_extension("file_browser")
telescope.load_extension("fzf")

vim.keymap.set('n', '<leader>f',
  function()
    builtin.find_files({
      no_ignore = false,
      hidden = true
    })
  end)
vim.keymap.set('n', '<leader>g', function()
  builtin.live_grep()
end)
vim.keymap.set('n', '<leader>r', function()
  builtin.oldfiles()
end)
vim.keymap.set('n', '<leader>b', function()
  builtin.buffers()
end)
vim.keymap.set('n', '<leader><leader>', function()
  builtin.resume()
end)
vim.keymap.set('n', '<leader>s', function()
  builtin.lsp_document_symbols()
end)
vim.keymap.set('n', '<leader>S', function()
  builtin.lsp_dynamic_workspace_symbols()
end)
