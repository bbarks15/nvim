-- Autocompletion
return {
  {
    'saghen/blink.cmp',
    lazy = false, -- lazy loading handled internally
    dependencies = {
      'rafamadriz/friendly-snippets',
    },
    version = '1.*',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      appearance = {
        kind_icons = require("core.icons").kind
      },
      keymap = {
        preset = "default",
        ['<Tab>'] = {},
        ['<S-Tab>'] = {},
        -- Snippets stay out of the regular menu: expand an exact trigger, otherwise pick from a snippets-only menu
        ['<C-j>'] = {
          'snippet_forward',
          function(cmp)
            return cmp.show({
              providers = { 'snippets' },
              callback = function()
                local first = cmp.get_items()[1]
                if first and first.exact then cmp.accept({ index = 1 }) end
              end,
            })
          end,
        },
        ['<C-k>'] = { 'snippet_backward', 'fallback' },
      },
      sources = {
        default = {
          'lsp',
          'path',
        },
        providers = {
          snippets = {
            opts = {
              extended_filetypes = { typescript = { 'javascript' } },
              filter_snippets = function(filetype) return filetype ~= 'terraform' end,
            },
          },
        },
      },
      completion = {
        accept = {
          auto_brackets = {
            enabled = false
          }
        },
        menu = {
          winhighlight = 'Normal:Normal,FloatBorder:Normal',
          max_height = 10,
          draw = {
            columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
          },
        },
        documentation = {
          auto_show = true,
          window = {
            winhighlight = 'Normal:Normal,FloatBorder:Normal',
            max_width = 60,
          }
        },
      },
      fuzzy = {
        implementation = "prefer_rust_with_warning",
        frecency = { enabled = false },
        use_proximity = false,
        sorts = { "exact", "score", "sort_text", "label" },
      },
    },
  },
}
