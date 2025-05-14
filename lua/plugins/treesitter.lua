---@diagnostic disable: missing-fields
-- Highlight, edit, and navigate code
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      -- "nvim-treesitter/nvim-treesitter-context",
      "JoosepAlviste/nvim-ts-context-commentstring",
      "windwp/nvim-ts-autotag",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        -- Add languages to be installed here that you want installed for treesitter
        ensure_installed = {
          "css",
          "html",
          "javascript",
          "json",
          "lua",
          "python",
          "rust",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "vue",
          "yaml",
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
          disable = { "python" }
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<c-space>",
            node_incremental = "<c-space>",
            scope_incremental = "<c-s>",
          },
        },
        -- autotag = {
        --   enable = true,
        --   enable_close_on_slash = false,
        -- },
        -- context_commentstring = {
        --   enable = true,
        --   enable_autocmd = false,
        -- },
      })

      -- require('ts_context_commentstring').setup {
      --   enable_autocmd = false
      -- }
      --
      require('nvim-ts-autotag').setup()

      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
    end,
  },
}
