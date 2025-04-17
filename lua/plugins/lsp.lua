-- LSP Configuration & Plugins
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      {
        "pmizio/typescript-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
      },
      { "j-hui/fidget.nvim" },
      "folke/neodev.nvim",
      "stevearc/conform.nvim",
      "elixir-tools/elixir-tools.nvim",
      {
        "b0o/SchemaStore.nvim",
        lazy = true,
        version = false, -- last release is way too old
      }
    },
    config = function()
      -- Set up Mason before anything else

      -- vim.lsp.set_log_level("debug")
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          'jsonls',
          "yamlls",
          "marksman",
          'tailwindcss',
          'cssls',
          'html',
          'svelte',
        },
        automatic_installation = true,
      })

      -- Neodev setup before LSP config
      require("neodev").setup()

      -- Turn on LSP status information
      require("fidget").setup({
        -- sources = {
        --   ["null-ls"] = { ignore = true, },
        -- },
        -- window = {
        --   blend = 0,
        -- },
      })

      -- Set up cool signs for diagnostics
      local icons = require("core.icons")

      require("helpers.keys").map(
        { "n", "x", "v" },
        "<leader>vd",
        function()
          vim.diagnostic.open_float({ border = "single" })
        end,
        "Show diagnostic"
      )


      -- Diagnostic config
      vim.diagnostic.config({
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = icons.diagnostics.Warning,
            [vim.diagnostic.severity.INFO] = icons.diagnostics.Information,
            [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
          },
        },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
          border = "single",
          source = "if_many",
          header = "",
          prefix = "",
        },
      })

      local on_attach = function(_, bufnr)
        local lsp_map = require("helpers.keys").lsp_map

        -- local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
        -- if
        --     filetype == "typescript"
        --     or filetype == "typescriptreact"
        --     or filetype == "typescript.tsx"
        --     or filetype == "javascript"
        --     or filetype == "javascriptreact"
        -- then
        --   lsp_map("gd", require("typescript-tools.api").go_to_source_definition, bufnr)
        -- else
        lsp_map("gd", vim.lsp.buf.definition, bufnr)
        -- end

        lsp_map("K", function()
          vim.lsp.buf.hover({ border = "single" })
        end, bufnr)

        lsp_map("gT", vim.lsp.buf.type_definition, bufnr)
        lsp_map("gD", vim.lsp.buf.declaration, bufnr)
        lsp_map("gi", vim.lsp.buf.implementation, bufnr)
        lsp_map("gr", vim.lsp.buf.references, bufnr)

        lsp_map("<leader>cs", function()
          vim.lsp.buf.signature_help({ border = "single" })
        end, bufnr)

        lsp_map("<leader>cr", vim.lsp.buf.rename, bufnr)
        lsp_map("<leader>cl", vim.lsp.codelens.run, bufnr)

        vim.keymap.set({ "n", "x", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr })

        lsp_map("<leader>i", vim.lsp.buf.incoming_calls, bufnr)
        lsp_map("<leader>o", vim.lsp.buf.outgoing_calls, bufnr)
        -- lsp_map(
        --   "<leader>ff",
        --   function()
        --     require("conform").format({ bufnr = bufnr, async = true, lsp_fallback = true, })
        --   end,
        --   bufnr
        -- )

        lsp_map("[d", function()
          vim.diagnostic.jump({ count = -1, float = true })
        end, bufnr)

        lsp_map("]d", function()
          vim.diagnostic.jump({ count = 1, float = true })
        end, bufnr)

        -- lsp_map("<leader>vd", vim.diagnostic.open_float, bufnr)
      end

      local capabilities = require('blink.cmp').get_lsp_capabilities()

      local lsps = {
        'tailwindcss',
        'cssls',
        'html',
        'svelte',
        "astro",
        "pylsp",
        "marksman",
        "terraformls",
        "tflint",
        "gopls",
        "yamlls",
        "zls",
        "biome"
      }
      for _, lsp in ipairs(lsps) do
        require("lspconfig")[lsp].setup({
          on_attach = on_attach,
          capabilities = capabilities
        })
      end

      require("lspconfig")["lua_ls"].setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              checkThirdParty = false,
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true,
              },
            },
          },
        },
      })

      require("typescript-tools").setup({
        on_attach = on_attach,
        settings = {
          complete_function_calls = false,
        },
      })

      require("lspconfig")["rust_analyzer"].setup({
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = { "rustup", "run", "stable", "rust-analyzer" },
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = { command = "clippy" },
          },
        },
      })

      local elixir = require("elixir")
      local elixirls = require("elixir.elixirls")

      elixir.setup({
        elixirls = {
          on_attach = on_attach,
          enable = true,
          settings = elixirls.settings {
            dialyzerEnabled = true,
            fetchDeps = true,
            enableTestLenses = false,
            suggestSpecs = false,
          },
        },
      })

      require('lspconfig').jsonls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
          },
        },
      }

      require('lspconfig').yamlls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          yaml = {
            schemaStore = {
              -- You must disable built-in schemaStore support if you want to use
              -- this plugin and its advanced options like `ignore`.
              enable = false,
              -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
              url = "",
            },
            schemas = require('schemastore').yaml.schemas(),
          },
        },
      }
    end,
  },
  {
    "stevearc/conform.nvim",
    keys = {
      {
        "<leader>ff",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        desc = "Format"
      },
    },
    opts = {
      log_level = vim.log.levels.DEBUG,
      formatters = {
        biome = {
          require_cwd = true,
          args = {
            "check",
            "--write",
            "--linter-enabled=false",
            "--stdin-file-path",
            "$FILENAME",
          },
        },
      },
      formatters_by_ft = {
        ["sql"] = { "sqlfluff" },
        ["javascript"] = { "biome", "prettierd", "prettier", stop_after_first = true },
        ["javascriptreact"] = { "biome", "prettierd", "prettier", stop_after_first = true },
        ["typescript"] = { "biome", "prettierd", "prettier", stop_after_first = true },
        ["typescriptreact"] = { "biome", "prettierd", "prettier", stop_after_first = true },
        ["astro"] = { "prettierd", "prettier", stop_after_first = true },
        ["vue"] = { "prettierd", "prettier", stop_after_first = true },
        ["css"] = { "biome", "prettierd", "prettier", stop_after_first = true },
        ["scss"] = { "prettierd", "prettier", stop_after_first = true },
        ["less"] = { "prettierd", "prettier", stop_after_first = true },
        ["html"] = { "prettierd", "prettier", stop_after_first = true },
        ["json"] = { "biome", "prettierd", "prettier", stop_after_first = true },
        ["jsonc"] = { "biome", "prettierd", "prettier", stop_after_first = true },
        ["yaml"] = { "prettierd", "prettier", stop_after_first = true },
        -- ["markdown"] =  { "prettierd", "prettier", stop_after_first = true },
        -- ["markdown.mdx"] =  { "prettierd", "prettier", stop_after_first = true },
        ["graphql"] = { "prettierd", "prettier", stop_after_first = true },
        ["handlebars"] = { "prettierd", "prettier", stop_after_first = true },
        go = { "goimports", "gofmt", "golines" },
        python = { "ruff_format", "ruff_fix" },
      },
    }
  },
  { 'dmmulroy/ts-error-translator.nvim', opts = {} },
}
