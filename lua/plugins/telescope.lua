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
    keys = {
      { "<C-P>",            function() require("telescope.builtin").find_files() end,                    desc = "Find files" },
      { "<leader>P",        function() require("telescope.builtin").commands() end,                      desc = "Commands" },
      { "<leader>F",        function() require("telescope.builtin").live_grep() end,                     desc = "Live grep" },
      { "<leader>r",        function() require("telescope.builtin").oldfiles() end,                      desc = "Recent files" },
      { "<leader>b",        function() require("telescope.builtin").buffers() end,                       desc = "Buffers" },
      { "<leader><leader>", function() require("telescope.builtin").resume() end,                        desc = "Resume" },
      { "<leader>s",        function() require("telescope.builtin").lsp_document_symbols() end,          desc = "Document symbols" },
      { "<leader>S",        function() require("telescope.builtin").lsp_dynamic_workspace_symbols() end, desc = "Workspace symbols" },
    },
    config = function()
      local actions = require("telescope.actions")
      require("telescope").setup({
        defaults = {
          mappings = {
            n = { ["q"] = actions.close },
          },
          file_ignore_patterns = {
            "^.git/",
            "^obj/",
            "^_build/",
            "^node_modules/",
            "^web/node_modules/",
            "^web/dist/",
            "^apps/web/dist/",
            "^.next/",
            "^.idea/",
            "^.vscode/",
            "^target/",
            "^deps/",
            "^.elixir_ls/",
            "^.elixir-tools/",
            ".svg$" },
        },
        pickers = {
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
              i = { ["<C-d>"] = actions.delete_buffer },
              n = { ["dd"] = actions.delete_buffer },
            },
          },
          git_files = {
            theme = "dropdown",
            hidden = true,
            previewer = false,
            show_untracked = true,
          },
        },
        extensions = {},
      })

      require('telescope').load_extension('luasnip')

      -- Enable telescope fzf native, if installed
      pcall(require("telescope").load_extension, "fzf")
    end,
  },
}
