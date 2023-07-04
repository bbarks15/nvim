-- vim.lsp.set_log_level("debug")

local status, nvim_lsp = pcall(require, "lspconfig")
if (not status) then return end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  -- Mappings.
  local opts = { noremap = true, silent = true }

  local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
  if filetype == "typescript" or filetype == "typescriptreact" or filetype == "typescript.tsx" then
    buf_set_keymap('n', 'gd', "<Cmd>TypescriptGoToSourceDefinition<CR>", opts)
  else
    buf_set_keymap('n', 'gd', "<Cmd>lua vim.lsp.buf.definition() <CR>", opts)
  end

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'K', "<Cmd>lua vim.lsp.buf.hover() <CR>", opts)
  buf_set_keymap('n', 'gT', "<Cmd>lua vim.lsp.buf.type_definition() <CR>", opts)
  buf_set_keymap('n', 'gD', "<Cmd>lua vim.lsp.buf.declaration() <CR>", opts)
  buf_set_keymap('n', 'gi', "<Cmd>lua vim.lsp.buf.implementation() <CR>", opts)
  buf_set_keymap("n", "gr", "<Cmd>lua vim.lsp.buf.references() <CR>", opts)
  buf_set_keymap('n', '<leader>cs', "<Cmd>lua vim.lsp.buf.signature_help() <CR>", opts)
  buf_set_keymap("n", "<leader>cr", "<Cmd>lua vim.lsp.buf.rename() <CR>", opts)
  buf_set_keymap("n", "<leader>i", "<Cmd>lua vim.lsp.buf.incoming_calls() <CR>", opts)
  buf_set_keymap("n", "<leader>o", "<Cmd>lua vim.lsp.buf.outgoing_calls() <CR>", opts)
  buf_set_keymap("n", "<leader>a", "<Cmd>lua vim.lsp.buf.code_action() <CR>", opts)
  buf_set_keymap('n', '<leader>f', "<Cmd>lua vim.lsp.buf.format({ filter = function(client) return client.name == \"null-ls\" end, bufnr = bufnr, }) <CR>", opts)

  buf_set_keymap('n', '[d', "<Cmd>lua vim.diagnostic.goto_prev() <CR>", opts)
  buf_set_keymap('n', ']d', "<Cmd>lua vim.diagnostic.goto_next() <CR>", opts)
  buf_set_keymap('n', '<leader>vd', "<Cmd>lua vim.diagnostic.open_float() <CR>", opts)
end

-- Set up completion using nvim_cmp with LSP source
local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("typescript").setup({
  disable_commands = false,
  debug = false,
  go_to_source_definition = { fallback = true, },
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
  },
})

require('haskell-tools').setup({
  hls = { on_attach = on_attach },
  tools = {
    hover = { disable = true, }
  }
})

nvim_lsp.lua_ls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = { globals = { 'vim' }, },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false
      },
    },
  },
}

nvim_lsp.jsonls.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

nvim_lsp.tailwindcss.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

nvim_lsp.cssls.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

nvim_lsp.html.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

nvim_lsp.svelte.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

nvim_lsp.omnisharp.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "dotnet", "C:\\Users\\bb11379\\AppData\\Local\\nvim-data\\mason\\packages\\omnisharp\\OmniSharp.dll" },
  -- enable_roslyn_analyzers = true,
  -- cmd = { "/home/brandon/.local/share/nvim/mason/bin/omnisharp" },
}

nvim_lsp.rust_analyzer.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "rustup", "run", "nightly", "rust-analyzer" },
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = { command = "clippy" }
    },
  },
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    update_in_insert = true,
    virtual_text = { spacing = 4, prefix = "●" },
    severity_sort = true,
  }
)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, { border = "single" }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, { border = "single" }
)

local icons = require('brandon.icons')

-- Diagnostic symbols in the sign column (gutter)
local signs = {
  Error = icons.diagnostics.Error,
  Warn = icons.diagnostics.Warning,
  Hint = icons.diagnostics.Hint,
  Info = icons.diagnostics.Information
}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
  virtual_text = { prefix = '●' },
  update_in_insert = true,
  float = { source = "always", },
})
