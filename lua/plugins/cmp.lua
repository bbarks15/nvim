-- Autocompletion
return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-buffer",
      "FelipeLema/cmp-async-path",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      local icons = require("core.icons")

      ---@diagnostic disable-next-line: missing-fields
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-c>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
        }),
        sources = cmp.config.sources({
          {
            name = "nvim_lsp",
            entry_filter = function(entry, _)
              return require("cmp.types").lsp.CompletionItemKind[entry:get_kind()] ~= "Text"
            end,
          },
          { name = "luasnip" },
          { name = "nvim_lsp_signature_help" },
          { name = "async_path" },
        }),
        ---@diagnostic disable-next-line: missing-fields
        formatting = {
          fields = { "abbr", "kind" },
          format = function(entry, item)
            -- item.abbr = string.sub(item.abbr, 1, 20)
            if icons.kind[item.kind] then
              item.kind = string.format('%s %s', icons.kind[item.kind], item.kind)
            end
            item.menu = ""
            -- item.menu = "[" .. (item.kind or "") .. "]"
            -- if icons.kind[item.kind] then
            --   item.kind = icons.kind[item.kind]
            -- end
            return item
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      })
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      local luasnip = require('luasnip')

      vim.snippet.expand = luasnip.lsp_expand

      ---@diagnostic disable-next-line: duplicate-set-field
      vim.snippet.active = function(filter)
        filter = filter or {}
        filter.direction = filter.direction or 1

        if filter.direction == 1 then
          return luasnip.expand_or_jumpable()
        else
          return luasnip.jumpable(filter.direction)
        end
      end

      ---@diagnostic disable-next-line: duplicate-set-field
      vim.snippet.jump = function(direction)
        if direction == 1 then
          if luasnip.expandable() then
            return luasnip.expand_or_jump()
          else
            return luasnip.jumpable(1) and luasnip.jump(1)
          end
        else
          return luasnip.jumpable(-1) and luasnip.jump(-1)
        end
      end

      vim.snippet.stop = luasnip.unlink_current

      luasnip.setup({
        history = true,
        updateevents = "TextChanged,TextChangedI",
        override_builtin = true,
      })

      require("luasnip.loaders.from_vscode").lazy_load {
        exclude = {},
      }

      -- <c-j> is my expansion key
      -- this will expand the current item or jump to the next item within the snippet.
      vim.keymap.set({ "i", "s" }, "<c-j>", function()
        return vim.snippet.active { direction = 1 } and vim.snippet.jump(1)
      end, { silent = true })

      -- <c-k> is my jump backwards key.
      -- this always moves to the previous item within the snippet
      vim.keymap.set({ "i", "s" }, "<c-k>", function()
        return vim.snippet.active { direction = -1 } and vim.snippet.jump(-1)
      end, { silent = true })

      -- <c-l> is selecting within a list of options.
      -- This is useful for choice nodes (introduced in the forthcoming episode 2)
      vim.keymap.set("i", "<c-l>", function()
        if luasnip.choice_active() then
          luasnip.change_choice(1)
        end
      end)
    end
  }
}
