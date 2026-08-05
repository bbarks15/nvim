---@diagnostic disable: missing-fields
-- Highlight, edit, and navigate code
return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      local treesitter_parsers = {
        "astro",
        "bash",
        "css",
        "dockerfile",
        "elixir",
        "gitcommit",
        "go",
        "hcl",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "python",
        "regex",
        "rust",
        "sql",
        "svelte",
        "terraform",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
        "zig",
      }
      require("nvim-treesitter").install(treesitter_parsers)

      local treesitter_filetypes =
          vim.iter(treesitter_parsers):map(vim.treesitter.language.get_filetypes):flatten():totable()

      vim.api.nvim_create_autocmd('FileType', {
        pattern = treesitter_filetypes,
        callback = function()
          vim.treesitter.start()
        end,
      })
    end,
  }
}
