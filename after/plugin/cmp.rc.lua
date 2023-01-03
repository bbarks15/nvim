local status, cmp = pcall(require, "cmp")
if (not status) then return end

local lspkind = require 'lspkind'
local luasnip = require("luasnip")

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-c>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true
    }),
  }),
  sources = cmp.config.sources({
    {
      name = 'nvim_lsp',
      entry_filter = function(entry, ctx)
        return require('cmp.types').lsp.CompletionItemKind[entry:get_kind()] ~= 'Text'
      end
    },
    -- { name = 'buffer' },
    { name = 'luasnip' },
    { name = 'nvim_lsp_signature_help' }
  }),
  formatting = {
    format = lspkind.cmp_format({ mode = 'symbol_text', maxwidth = 50 })
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
})



--vim.cmd [[
--  set completeopt=menuone,noinsert,noselect
--
--  imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
--  inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>
--  snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
--  snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>
--]]

-- " Use <Tab> and <S-Tab> to navigate through popup menu
-- inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
-- inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
