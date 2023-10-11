return {
  -- {
  --   "nvim-tree/nvim-tree.lua",
  --   lazy = false,
  --   dependencies = {
  --     "nvim-tree/nvim-web-devicons",
  --   },
  --   config = function()
  --     require("nvim-tree").setup({
  --       view = { signcolumn = "no", },
  --       renderer = {
  --         root_folder_label = false,
  --         indent_markers = {
  --           enable = true,
  --         },
  --         icons = {
  --           git_placement = "after",
  --           glyphs = {
  --             folder = {
  --               default = '',
  --               open = '',
  --               symlink = '',
  --             },
  --           },
  --           show = {
  --             file = true,
  --             folder = true,
  --             folder_arrow = true,
  --             git = true,
  --           },
  --         },
  --       }
  --     })
  --
  --     vim.keymap.set("n", "<leader>e", "<CMD>NvimTreeToggle<CR>")
  --     vim.keymap.set("n", "<leader>E", "<CMD>NvimTreeFindFile<CR>")
  --   end,
  -- },
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        default_component_configs = {
          icon = {
            -- folder_closed = "",
            -- folder_open = "",
            folder_closed = '',
            folder_open = '',
            folder_empty = "󰜌",
          },
        },
        filesystem = {
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
          }
        }
      })

      require("helpers.keys").map(
        { "n", "v" },
        "<leader>e",
        function()
          require("neo-tree.command").execute({ toggle = true })
        end,
        "Toggle file explorer"
      )


      require("helpers.keys").map(
        { "n", "v" },
        "<leader>E",
        function()
          require("neo-tree.command").execute({ toggle = true, reveal = true })
        end,
        "Toggle file explorer"
      )
    end

  }
}
