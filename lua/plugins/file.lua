return {
  -- {
  --   'echasnovski/mini.files',
  --   version = false,
  --   config = function()
  --     require("mini.files").setup()
  --
  --     vim.api.nvim_create_autocmd('User', {
  --       pattern = 'MiniFilesWindowOpen',
  --       callback = function(args)
  --         local win_id = args.data.win_id
  --
  --         -- Customize window-local settings
  --         -- vim.wo[win_id].winblend = 50
  --         vim.api.nvim_win_set_config(win_id, { border = "rounded" })
  --       end,
  --     })
  --
  --     require("helpers.keys").map(
  --       { "n", "v" },
  --       "<leader>e",
  --       MiniFiles.open,
  --       "Toggle file explorer"
  --     )
  --
  --     require("helpers.keys").map(
  --       { "n", "v" },
  --       "<leader>E",
  --       function()
  --         MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
  --       end,
  --       "Toggle file explorer"
  --     )
  --   end
  -- },
  ---@type LazySpec
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
      -- 👇 in this section, choose your own keymappings!
      {
        "<leader>E",
        "<cmd>Yazi<cr>",
        desc = "Open yazi at the current file",
      },
      {
        -- Open in the current working directory
        "<leader>e",
        "<cmd>Yazi toggle<cr>",
        desc = "Open the file manager in nvim's working directory",
      },
    },
    ---@type YaziConfig
    opts = {
      open_for_directories = false,
      keymaps = {
        show_help = '<f1>',
      },
    },
  }
}
