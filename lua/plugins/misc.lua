-- Miscelaneous fun stuff
return {
  {
    "echasnovski/mini.comment",
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    config = function()
      require('mini.comment').setup {
        options = {
          custom_commentstring = function()
            return require('ts_context_commentstring.internal').calculate_commentstring() or vim.bo.commentstring
          end,
        },
      }
    end,
  },
  {
    "echasnovski/mini.surround",
    config = true,
  },
  {
    "echasnovski/mini.pairs",
    config = true,
  },
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true,
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "kevinhwang91/nvim-bqf",
    opts = { preview = { winblend = 0 } },
  },
  {
    "ThePrimeagen/harpoon",
    config = function()
      require("harpoon").setup()

      local map = require("helpers.keys").map

      map("n", "<leader>m", require("harpoon.mark").add_file)
      map("n", "<C-e>", require("harpoon.ui").toggle_quick_menu)

      map("n", "<leader>h", function()
        require("harpoon.ui").nav_file(1)
      end)
      map("n", "<leader>j", function()
        require("harpoon.ui").nav_file(2)
      end)
      map("n", "<leader>k", function()
        require("harpoon.ui").nav_file(3)
      end)
      map("n", "<leader>l", function()
        require("harpoon.ui").nav_file(4)
      end)

      for i = 1, 9 do
        vim.keymap.set("n", string.format("<leader>%s", i), function()
          require("harpoon.ui").nav_file(i)
        end)
      end
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      panel = {
        auto_refresh = true,
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = "<M-l>",
          accept_word = false,
          accept_line = false,
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
    },
  }
}
