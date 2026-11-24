-- LSP Configuration & Plugins
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-org/mason.nvim",
      {
        "b0o/SchemaStore.nvim",
        lazy = true,
        version = false, -- last release is way too old
      }
    },
    config = function()
      require("mason").setup()

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

          vim.keymap.set({ "n", "v" }, "gra", function()
            vim.lsp.buf.code_action({
              filter = function(action)
                return not action.disabled
              end,
            })
          end, { buffer = buffer, desc = "Code action" })
        end,
      })

      vim.api.nvim_create_autocmd('LspProgress', {
        group = vim.api.nvim_create_augroup('brandon-lsp-progress', { clear = true }),
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

      -- TS 7 ships no tsserver.js, so vtsls would silently fall back to its bundled TS 5.9.
      -- Send TS7+ workspaces to tsc, everything else to vtsls.
      local base = { tsc = vim.lsp.config.tsc, vtsls = vim.lsp.config.vtsls }

      local ts7_by_dir = {}

      local function is_ts7(bufnr)
        local name = vim.api.nvim_buf_get_name(bufnr)
        if name == "" then return false end
        local start = vim.fs.dirname(name)
        if ts7_by_dir[start] ~= nil then return ts7_by_dir[start] end

        local result = false
        for dir in vim.fs.parents(name) do
          local pkg = vim.fs.joinpath(dir, "node_modules", "typescript", "package.json")
          if vim.fn.filereadable(pkg) == 1 then
            local ok, json = pcall(vim.json.decode, table.concat(vim.fn.readfile(pkg), "\n"))
            local major = ok and tonumber((json.version or ""):match("^(%d+)%."))
            result = major ~= nil and major >= 7
            break
          end
        end
        ts7_by_dir[start] = result
        return result
      end

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
        zls = {},
        cssls = {},
        html = {},
        svelte = {},
        tailwindcss = {},
        vtsls = {
          root_dir = function(bufnr, on_dir)
            if not is_ts7(bufnr) then base.vtsls.root_dir(bufnr, on_dir) end
          end,
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
        tsc = {
          cmd = base.tsc.cmd, -- must come from base.tsc, it shares state with root_dir
          root_dir = function(bufnr, on_dir)
            if is_ts7(bufnr) then base.tsc.root_dir(bufnr, on_dir) end
          end,
          -- TS7 merges javascript < typescript < js/ts into one set, so per-language prefs don't exist
          settings = {
            ["js/ts"] = {
              preferences = {
                importModuleSpecifier = "non-relative",
                -- ~1700 icon exports drown every other candidate; import them by hand
                autoImportSpecifierExcludeRegexes = { "^@hugeicons/core-free-icons" },
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
          -- Build the schema list when the server starts, not at every launch
          before_init = function(_, config)
            config.settings.json.schemas = require('schemastore').json.schemas()
          end,
          settings = {
            json = {
              validate = { enable = true },
            },
          },
        },
        yamlls = {
          before_init = function(_, config)
            config.settings.yaml.schemas = require('schemastore').yaml.schemas()
          end,
          settings = {
            yaml = {
              schemaStore = {
                -- You must disable built-in schemaStore support if you want to use
                -- this plugin and its advanced options like `ignore`.
                enable = false,
                -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                url = "",
              },
            },
          },
        }
      }

      for server, config in pairs(lsps) do
        vim.lsp.config(server, config)
        vim.lsp.enable(server)
      end
    end,
  },
  {
    -- Only used to install servers, so it can wait until after startup
    "mason-org/mason-lspconfig.nvim",
    event = "VeryLazy",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
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
        "tailwindcss",
        "terraformls",
        "tflint",
        "vtsls",
        "yamlls",
        "zls",
      },
      automatic_enable = false,
    },
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
        go = { "goimports", "golines" },
        python = { "ruff_fix", "ruff_format" },
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
