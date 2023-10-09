-- Nicer filetree than NetRW
return {
  -- {
  --   "nvim-neo-tree/neo-tree.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-tree/nvim-web-devicons",
  --     "MunifTanjim/nui.nvim",
  --   },
  --   config = function()
  --     require("neo-tree").setup()
  --     require("helpers.keys").map(
  --       { "n", "v" },
  --       "<leader>e",
  --       "<cmd>Neotree toggle<cr>",
  --       "Toggle file explorer"
  --     )
  --   end,
  -- },
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
