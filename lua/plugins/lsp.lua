-- LSP Configuration & Plugins
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "j-hui/fidget.nvim",
      "stevearc/conform.nvim",
      "elixir-tools/elixir-tools.nvim",
      {
        "b0o/SchemaStore.nvim",
        lazy = true,
        version = false, -- last release is way too old
      }
    },
    config = function()
      -- vim.lsp.set_log_level("debug")
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "astro",
          "biome",
          "cssls",
          "gopls",
          "html",
          "jsonls",
          "lua_ls",
          "marksman",
          "pyright",
          "svelte",
          "terraformls",
          "tflint",
          "vtsls",
          "yamlls",
          "zls",
        },
        automatic_enable = false,
      })

      -- Turn on LSP status information
      require("fidget").setup({
        -- notification = {
        --   window = {
        --     normal_hl = "None",
        --     winblend = 0,
        --   }
        -- }
      })

      -- Set up cool signs for diagnostics
      local icons = require("core.icons")

      -- require("helpers.keys").map(
      --   { "n", "x", "v" },
      --   "<leader>vd",
      --   function()
      --     vim.diagnostic.open_float({ border = "single" })
      --   end,
      --   "Show diagnostic"
      -- )

      -- Diagnostic config
      vim.diagnostic.config({
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

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('brandon-lsp-attach', { clear = true }),
        callback = function(event)
          local b = event.buf

          vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = b, desc = "Go to definition" })
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = b, desc = "Go to declaration" })
          vim.keymap.set("n", "<leader>i", vim.lsp.buf.incoming_calls, { buffer = b, desc = "Incoming calls" })
          vim.keymap.set("n", "<leader>o", vim.lsp.buf.outgoing_calls, { buffer = b, desc = "Outgoing calls" })
          vim.keymap.set("n", "K", function()
            vim.lsp.buf.hover({ border = "single" })
          end, { buffer = b, desc = "Hover" })
        end,
      })

      local capabilities = require('blink.cmp').get_lsp_capabilities()

      local lsps = {
        astro = {},
        biome = {},
        gopls = {},
        marksman = {},
        pyright = {},
        terraformls = {},
        tflint = {},
        zls = {
          -- enable_build_on_save = true,
        },
        -- copilot = {},
        cssls = {},
        html = {},
        svelte = {},
        tailwindcss = {},
        vtsls = {
          filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
            "vue"
          },
          settings = {
            vtsls = {
              enableMoveToFileCodeAction = true,
              autoUseWorkspaceTsdk = true,
              experimental = {
                completion = {
                  enableServerSideFuzzyMatch = true,
                },
              },
              -- tsserver = {},
            },
            typescript = {
              updateImportsOnFileMove = { enabled = "always" },
              preferences = {
                importModuleSpecifier = "non-relative"
              }
            },
            javascript = {
              updateImportsOnFileMove = { enabled = "always" },
              preferences = {
                importModuleSpecifier = "project-relative"
              }
            },
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
        rust_analyzer = {
          cmd = { "rustup", "run", "stable", "rust-analyzer" },
        },
        jsonls = {
          settings = {
            json = {
              schemas = require('schemastore').json.schemas(),
              validate = { enable = true },
            },
          },
        },
        yamlls = {
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
      }

      for server, config in pairs(lsps) do
        config.capabilities = vim.tbl_deep_extend('force', {}, capabilities, config.capabilities or {})
        vim.lsp.config(server, config)
        vim.lsp.enable(server)
      end

      local elixir = require("elixir")
      local elixirls = require("elixir.elixirls")

      elixir.setup({
        elixirls = {
          enable = true,
          settings = elixirls.settings {
            dialyzerEnabled = true,
            fetchDeps = true,
            enableTestLenses = false,
            suggestSpecs = false,
          },
        },
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    keys = {
      {
        "<leader>ff",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        desc = "Format"
      },
    },
    opts = {
      -- log_level = vim.log.levels.DEBUG,
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
        ["sql"] = { "sleek" },
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
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}
