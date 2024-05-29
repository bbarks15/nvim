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
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "kevinhwang91/nvim-bqf",
    opts = { preview = { winblend = 0 } },
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")

      harpoon:setup()

      local map = require("helpers.keys").map

      map("n", "<leader>m", function() harpoon:list():append() end)
      map("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

      map("n", "<leader>h", function() harpoon:list():select(1) end)
      map("n", "<leader>j", function() harpoon:list():select(2) end)
      map("n", "<leader>k", function() harpoon:list():select(3) end)
      map("n", "<leader>l", function() harpoon:list():select(4) end)

      for i = 1, 9 do
        vim.keymap.set("n", string.format("<leader>%s", i), function()
          harpoon:list():select(i)
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
  },
  {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim", -- required by telescope
      "MunifTanjim/nui.nvim",
    },
    opts = {
      ---@type lc.lang
      lang = "python3",
    },
  }
}
