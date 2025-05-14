-- LSP Configuration & Plugins
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "j-hui/fidget.nvim",
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
          "ts_ls",
          'html',
          'svelte',
        },
        automatic_installation = true,
        automatic_enable = false,
      })

      -- Neodev setup before LSP config
      require("neodev").setup()

      -- Turn on LSP status information
      require("fidget").setup({
        notification = {
          window = {
            winblend = 0,
          }
        }
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

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('brandon-lsp-attach', { clear = true }),
        callback = function(event)
          local bufnr = event.buf
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

          -- local map = function(keys, func, desc, mode)
          --   mode = mode or 'n'
          --   vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          -- end
          --
          -- map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
          -- map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
          -- map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          -- map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          -- map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          -- map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          -- map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')
          -- map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')
          -- map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')
          -- This may be unwanted, since they displace some of your code
          -- if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
          --   map('<leader>th', function()
          --     vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
          --   end, '[T]oggle Inlay [H]ints')
          -- end
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
        yamlls = {},
        zls = {},
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
          },
          settings = {
            complete_function_calls = true,
            vtsls = {
              enableMoveToFileCodeAction = true,
              autoUseWorkspaceTsdk = true,
              experimental = {
                completion = {
                  enableServerSideFuzzyMatch = true,
                },
              },
            },
            typescript = {
              updateImportsOnFileMove = { enabled = "always" },
              suggest = {
                completeFunctionCalls = true,
              },
            },
            javascript = {
              updateImportsOnFileMove = { enabled = "always" },
              suggest = {
                completeFunctionCalls = true,
              },
            },
          },
        },
        lua_ls = {
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
        },
        volar = {
          filetypes = { 'vue' },
          init_options = {
            typescript = {
              tsdk = vim.fn.stdpath 'data' .. '/mason/packages/typescript-language-server/node_modules/typescript/lib',
            },
            vue = {
              hybridMode = false,
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
        yammls = {
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
          require("conform").format({ async = true, lsp_fallback = true })
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
