return {
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
            folder_closed = " ",
            folder_open = " ",
            -- folder_closed = '',
            -- folder_open = '',
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
