return {
  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup({
        view = { signcolumn = "no", },
        renderer = {
          root_folder_label = false,
          indent_markers = {
            enable = true,
          },
          icons = {
            git_placement = "after",
            glyphs = {
              folder = {
                default = '',
                open = '',
                symlink = '',
              },
            },
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            },
          },
        }
      })

      vim.keymap.set("n", "<leader>e", "<CMD>NvimTreeToggle<CR>")
      vim.keymap.set("n", "<leader>E", "<CMD>NvimTreeFindFile<CR>")
    end,
  }
}
