-- LSP Configuration & Plugins
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      -- "j-hui/fidget.nvim",
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
          "eslint",
          "expert",
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
      -- require("fidget").setup({
      --   -- notification = {
      --   --   window = {
      --   --     normal_hl = "None",
      --   --     winblend = 0,
      --   --   }
      --   -- }
      -- })

      -- Set up cool signs for diagnostics
      local icons = require("core.icons")

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
          local buffer = event.buf

          vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = buffer, desc = "Go to definition" })
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = buffer, desc = "Go to declaration" })
          vim.keymap.set("n", "<leader>i", vim.lsp.buf.incoming_calls, { buffer = buffer, desc = "Incoming calls" })
          vim.keymap.set("n", "<leader>o", vim.lsp.buf.outgoing_calls, { buffer = buffer, desc = "Outgoing calls" })

          vim.keymap.set("n", "K", function()
            vim.lsp.buf.hover({ border = "single" })
          end, { buffer = buffer, desc = "Hover" })

          vim.keymap.set({ "n", "v" }, "gra", function()
            vim.lsp.buf.code_action({
              filter = function(action)
                return not action.disabled
              end,
            })
          end, { buffer = buffer, desc = "Code action" })

          vim.api.nvim_create_autocmd('LspProgress', {
            buffer = buffer,
            callback = function(ev)
              local value = ev.data.params.value
              vim.api.nvim_echo({ { value.message or 'done' } }, false, {
                id = 'lsp.' .. ev.data.client_id,
                kind = 'progress',
                source = 'vim.lsp',
                title = value.title,
                status = value.kind ~= 'end' and 'running' or 'success',
                percent = value.percentage,
              })
            end,
          })
        end,
      })

      local capabilities = require('blink.cmp').get_lsp_capabilities()

      local lsps = {
        astro = {},
        biome = {},
        eslint = {
          root_dir = function(bufnr, on_dir)
            local fname = vim.api.nvim_buf_get_name(bufnr)
            local eslint_configs = vim.fs.find({
              'eslint.config.js', 'eslint.config.mjs', 'eslint.config.cjs',
              'eslint.config.ts', 'eslint.config.mts', 'eslint.config.cts',
              '.eslintrc', '.eslintrc.js', '.eslintrc.cjs', '.eslintrc.yaml',
              '.eslintrc.yml', '.eslintrc.json',
            }, { path = fname, upward = true })
            if eslint_configs[1] then
              on_dir(vim.fn.fnamemodify(eslint_configs[1], ':h'))
            end
          end,
        },
        gopls = {},
        marksman = {},
        oxlint = {},
        pyright = {},
        terraformls = {},
        tflint = {},
        expert = {},
        zls = {
          -- enable_build_on_save = true,
        },
        -- copilot = {},
        cssls = {},
        html = {},
        svelte = {},
        tailwindcss = {},
        -- replaced by tsgo; TS 7 ships no tsserver so vtsls falls back to its own TS 5.9
        --[[
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
            vtsls = {
              enableMoveToFileCodeAction = true,
              autoUseWorkspaceTsdk = true,
              experimental = {
                completion = {
                  enableServerSideFuzzyMatch = true, -- keep ON, it's a perf win
                  entriesLimit = 100,                -- cap candidates returned
                },
              },
            },
            typescript = {
              tsserver = {
                maxTsServerMemory = 8192, -- biggest lever for large projects (default 3072)
              },
              updateImportsOnFileMove = { enabled = "always" },
              -- workspaceSymbols.scope left at default → searches the whole monorepo
              preferences = {
                importModuleSpecifier = "non-relative",
                includePackageJsonAutoImports = "auto",
                autoImportFileExcludePatterns = {
                  "**/node_modules/**",
                  "**/dist/**",
                  "**/build/**",
                  "**/.next/**",
                },
              },
            },
            javascript = {
              updateImportsOnFileMove = { enabled = "always" },
              preferences = {
                importModuleSpecifier = "project-relative",
                includePackageJsonAutoImports = "auto",
              },
            },
          },
        },
        --]]
        tsgo = {
          -- TS 7 stable ships the Go LSP as `tsc`; lspconfig still looks for `tsgo`
          cmd = function(dispatchers, config)
            local bin = vim.fs.joinpath((config or {}).root_dir or vim.fn.getcwd(), "node_modules/.bin/tsc")
            if vim.fn.executable(bin) == 0 then bin = "tsgo" end
            return vim.lsp.rpc.start({ bin, "--lsp", "--stdio" }, dispatchers)
          end,
          settings = {
            typescript = {
              preferences = {
                importModuleSpecifier = "non-relative",
                -- ~1700 icon exports drown every other candidate; import them by hand
                autoImportSpecifierExcludeRegexes = { "^@hugeicons/core-free-icons" },
              },
            },
            javascript = {
              preferences = {
                importModuleSpecifier = "project-relative",
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

      -- local elixir = require("elixir")
      -- local elixirls = require("elixir.elixirls")
      --
      -- elixir.setup({
      --   elixirls = {
      --     enable = true,
      --     settings = elixirls.settings {
      --       dialyzerEnabled = true,
      --       fetchDeps = true,
      --       enableTestLenses = false,
      --       suggestSpecs = false,
      --     },
      --   },
      -- })
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
        ["javascript"] = { "oxfmt", "biome", "prettierd", "prettier", stop_after_first = true },
        ["javascriptreact"] = { "oxfmt", "biome", "prettierd", "prettier", stop_after_first = true },
        ["typescript"] = { "oxfmt", "biome", "prettierd", "prettier", stop_after_first = true },
        ["typescriptreact"] = { "oxfmt", "biome", "prettierd", "prettier", stop_after_first = true },
        ["astro"] = { "prettierd", "prettier", stop_after_first = true },
        ["css"] = { "oxfmt", "biome", "prettierd", "prettier", stop_after_first = true },
        ["scss"] = { "prettierd", "prettier", stop_after_first = true },
        ["less"] = { "prettierd", "prettier", stop_after_first = true },
        ["html"] = { "prettierd", "prettier", stop_after_first = true },
        ["json"] = { "oxfmt", "biome", "prettierd", "prettier", stop_after_first = true },
        ["jsonc"] = { "oxfmt", "biome", "prettierd", "prettier", stop_after_first = true },
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
}
