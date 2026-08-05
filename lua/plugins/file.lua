return {
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
