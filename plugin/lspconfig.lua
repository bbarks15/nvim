-- vim.lsp.set_log_level("debug")

local status, nvim_lsp = pcall(require, "lspconfig")
if (not status) then return end

local nmap = require("brandon.keymap").nmap

local buf_nnoremap = function(opts)
  if opts[3] == nil then
    opts[3] = {}
  end
  opts[3].buffer = 0

  nmap(opts)
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)

  local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
  if filetype == "typescript" or filetype == "typescriptreact" or filetype == "typescript.tsx" then
    buf_nnoremap { "gd", "<Cmd>TypescriptGoToSourceDefinition<CR>" }
  else
    buf_nnoremap { "gd", vim.lsp.buf.definition }
  end

  local lsp_formatting = function()
    vim.lsp.buf.format({
      filter = function(client)
        return client.name == "null-ls"
      end,
      bufnr = bufnr,
    })
  end


  -- See `:help vim.lsp.*` for documentation on any of the below functions
  -- buf_nnoremap { "K", vim.lsp.buf.hover }
  buf_nnoremap { "K", vim.lsp.buf.hover }
  buf_nnoremap { "gT", vim.lsp.buf.type_definition }
  buf_nnoremap { "gD", vim.lsp.buf.declaration }
  buf_nnoremap { "gi", vim.lsp.buf.implementation }
  buf_nnoremap { "gr", vim.lsp.buf.references }
  buf_nnoremap { "<leader>cs", vim.lsp.buf.signature_help }
  buf_nnoremap { "<leader>cr", vim.lsp.buf.rename }
  buf_nnoremap { "<leader>i", vim.lsp.buf.incoming_calls }
  buf_nnoremap { "<leader>o", vim.lsp.buf.outgoing_calls }
  buf_nnoremap { "<leader>a", vim.lsp.buf.code_action }
  buf_nnoremap { "<leader>f", lsp_formatting }

  buf_nnoremap { "[d", vim.diagnostic.goto_prev }
  buf_nnoremap { "]d", vim.diagnostic.goto_next }
  buf_nnoremap { "<leader>vd", vim.diagnostic.open_float }

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
