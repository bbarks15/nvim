-- Telescope fuzzy finding (all the things)
return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = vim.fn.executable("make") == 1
      },
      "benfowler/telescope-luasnip.nvim",
    },
    config = function()
      local function get_pickers(a)
        return {
          find_files = {
            theme = "dropdown",
            hidden = true,
            previewer = false,
          },
          commands = {
            theme = "dropdown",
            hidden = true,
            previewer = false,
          },
          lsp_document_symbols = {
            theme = "dropdown",
            hidden = true,
            symbol_width = 50,
            previewer = false,
          },
          buffers = {
            theme = "dropdown",
            previewer = false,
            initial_mode = "normal",
            mappings = {
              i = { ["<C-d>"] = a.delete_buffer },
              n = { ["dd"] = a.delete_buffer },
            },
          },
          git_files = {
            theme = "dropdown",
            hidden = true,
            previewer = false,
            show_untracked = true,
          },
        }
      end

      local actions = require("telescope.actions")
      require("telescope").setup({
        defaults = {
          mappings = {
            n = { ["q"] = actions.close },
          },
          pickers = get_pickers(actions),
          file_ignore_patterns = {
            ".git/",
            "^obj/",
            "^_build/",
            "^node_modules/",
            "^web/node_modules/",
            "^web/dist/",
            "^.next/",
            "^.idea/",
            "^.vscode/",
            "^target/",
            "^deps/",
            "^.elixir_ls/",
            "^.elixir-tools/",
            ".svg$" },
        },
        pickers = get_pickers(actions),
        extensions = {},
      })

      require('telescope').load_extension('luasnip')

      -- Enable telescope fzf native, if installed
      pcall(require("telescope").load_extension, "fzf")

      local map = require("helpers.keys").map
      local builtin = require("telescope.builtin")

      map("n", "<C-P>", builtin.git_files)
      map("n", "<leader>P", builtin.commands)
      map("n", "<leader>F", builtin.live_grep)
      map("n", "<leader>r", builtin.oldfiles)
      map("n", "<leader>b", builtin.buffers)
      map("n", "<leader><leader>", builtin.resume)
      map("n", "<leader>s", builtin.lsp_document_symbols)
      map("n", "<leader>S", builtin.lsp_dynamic_workspace_symbols)
    end,
  },
}
