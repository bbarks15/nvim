local status, rt = pcall(require, "rust-tools")
if (not status) then return end

rt.setup({
  inlay_hints = {
    show_parameter_hints = false,
  },
  server = {
    on_attach = function(c, b)
      local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(b, ...) end

      local opts = { noremap = true, silent = true }
      buf_set_keymap('n', 'gt', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
      buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
      buf_set_keymap('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
      buf_set_keymap('i', '<C-h>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
      buf_set_keymap('n', '<C-h>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

    end,
    cmd = { "rustup", "run", "nightly", "rust-analyzer" },
  }
})
