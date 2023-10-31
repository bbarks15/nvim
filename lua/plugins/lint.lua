return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      debug = false,
      sources = {
        -- null_ls.builtins.diagnostics.eslint_d,
        -- null_ls.builtins.code_actions.eslint_d,
        null_ls.builtins.diagnostics.eslint_d.with({
          condition = function(utils)
            return utils.root_has_file({
              ".eslintrc.js",
              ".eslintrc.cjs",
              ".eslintrc.yaml",
              ".eslintrc.yml",
              ".eslintrc.json",
            })
          end,
        }),
        null_ls.builtins.code_actions.eslint_d.with({
          condition = function(utils)
            return utils.root_has_file({
              ".eslintrc.js",
              ".eslintrc.cjs",
              ".eslintrc.yaml",
              ".eslintrc.yml",
              ".eslintrc.json",
            })
          end,
        }),
      },
    })
  end,
}
