return {
  {
    'echasnovski/mini.files',
    version = false,
    config = function()
      require("mini.files").setup()

      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesWindowOpen',
        callback = function(args)
          local win_id = args.data.win_id

          -- Customize window-local settings
          -- vim.wo[win_id].winblend = 50
          vim.api.nvim_win_set_config(win_id, { border = "rounded" })
        end,
      })

      require("helpers.keys").map(
        { "n", "v" },
        "<leader>e",
        MiniFiles.open,
        "Toggle file explorer"
      )

      require("helpers.keys").map(
        { "n", "v" },
        "<leader>E",
        function()
          MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
        end,
        "Toggle file explorer"
      )
    end
  }
}
