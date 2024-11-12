-- Autocompletion
return {
  {
    'saghen/blink.cmp',
    lazy = false, -- lazy loading handled internally
    dependencies = {
      'rafamadriz/friendly-snippets',
      "L3MON4D3/LuaSnip",
    },
    build = 'cargo build --release',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = { preset = 'default' },
      highlight = {
        -- sets the fallback highlight groups to nvim-cmp's highlight groups
        -- useful for when your theme doesn't support blink.cmp
        -- will be removed in a future release, assuming themes add support
        use_nvim_cmp_as_default = true,
      },
      nerd_font_variant = 'normal',

      accept = { auto_brackets = { enabled = true } },
      trigger = { signature_help = { enabled = false } },

      sources = {
        completion = {
          enabled_providers = { 'lsp', 'path', 'snippets', }
        }
      },

      windows = {
        autocomplete = {
          border = 'rounded',
          winhighlight = 'Normal:Normal,FloatBorder:Normal',
          draw = {
            columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
          },
        },
        documentation = {
          border = 'rounded',
          winhighlight = 'Normal:Normal,FloatBorder:Normal',
          max_width = 60,
          auto_show = true,
        }
      },

      kind_icons = require("core.icons").kind
    },
  },
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      local ls = require("luasnip")

      vim.snippet.expand = ls.lsp_expand

      ---@diagnostic disable-next-line: duplicate-set-field
      vim.snippet.active = function(filter)
        filter = filter or {}
        filter.direction = filter.direction or 1

        if filter.direction == 1 then
          return ls.expand_or_jumpable()
        else
          return ls.jumpable(filter.direction)
        end
      end

      ---@diagnostic disable-next-line: duplicate-set-field
      vim.snippet.jump = function(direction)
        if direction == 1 then
          if ls.expandable() then
            return ls.expand_or_jump()
          else
            return ls.jumpable(1) and ls.jump(1)
          end
        else
          return ls.jumpable(-1) and ls.jump(-1)
        end
      end

      vim.snippet.stop = ls.unlink_current

      vim.snippet.stop = ls.unlink_current

      ls.setup({
        history = true,
        updateevents = "TextChanged,TextChangedI",
        override_builtin = true,
      })

      require("luasnip.loaders.from_vscode").lazy_load {
        exclude = { "terraform" },
      }

      vim.keymap.set({ "i", "s" }, "<c-j>", function()
        return vim.snippet.active { direction = 1 } and vim.snippet.jump(1)
      end, { silent = true })

      vim.keymap.set({ "i", "s" }, "<c-k>", function()
        return vim.snippet.active { direction = -1 } and vim.snippet.jump(-1)
      end, { silent = true })

      vim.keymap.set("i", "<c-l>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end)
    end
  }
}
