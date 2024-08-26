return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      debug = false,
      sources = {
        -- null_ls.builtins.diagnostics.ruff,
        -- null_ls.builtins.diagnostics.mypy,
        require("none-ls.diagnostics.eslint").with({
          condition = function()
            local bufname = vim.api.nvim_buf_get_name(0)
            local root = require('null-ls.utils').cosmiconfig("eslint", "eslintConfig")(bufname)

            return root ~= nil
          end,
        }),
        require("none-ls.code_actions.eslint").with({
          condition = function()
            local bufname = vim.api.nvim_buf_get_name(0)
            local root = require('null-ls.utils').cosmiconfig("eslint", "eslintConfig")(bufname)

            return root ~= nil
          end,
        }),
      },
    })
  end,
}
