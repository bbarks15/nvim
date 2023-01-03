local status, saga = pcall(require, "lspsaga")
if (not status) then return end

saga.init_lsp_saga {
  server_filetype_map = {
    typescript = 'typescript'
  },
  code_action_lightbulb = {
    enable = true,
    virtual_text = false,
    sign = true,
  },
  show_outline = {
    win_position = 'right',
    --set special filetype win that outline window split.like NvimTree neotree
    -- defx, db_ui
    win_with = '',
    win_width = 30,
    auto_enter = true,
    auto_preview = true,
    virt_text = '┃',
    jump_key = 'o',
    -- auto refresh when change buffer
    auto_refresh = true,
  },
}

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<C-j>', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)
vim.keymap.set('n', 'gd', '<Cmd>Lspsaga lsp_finder<CR>', opts)
vim.keymap.set('n', 'gp', '<Cmd>Lspsaga peek_definition<CR>', opts)
vim.keymap.set('n', '<leader>cr', '<Cmd>Lspsaga rename<CR>', opts)
vim.keymap.set('n', '<leader>ca', "<cmd>Lspsaga code_action<CR>", opts)
vim.keymap.set('v', '<leader>ca', "<cmd>Lspsaga code_action<CR>", opts)
