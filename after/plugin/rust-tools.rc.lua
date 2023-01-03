local status, rt = pcall(require, "rust-tools")
if (not status) then return end

rt.setup({
  tools = {
    inlay_hints = {
    },
  },
  server = {
    on_attach = function(c, b)
      local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(b, ...) end

      local opts = { noremap = true, silent = true }
      buf_set_keymap('n', 'gT', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
      buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
      buf_set_keymap('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    end,
    cmd = { "rustup", "run", "nightly", "rust-analyzer" },
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy"
        }
      }
    }
  }
})
