-- Miscelaneous fun stuff
return {
  {
    "echasnovski/mini.surround",
    opts = {},
  },
  {
    "echasnovski/mini.pairs",
    opts = {
      modes = { insert = true, command = true, terminal = false },
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      skip_ts = { "string" },
      skip_unbalanced = true,
      markdown = true,
    },
  },
  {
    "rachartier/tiny-devicons-auto-colors.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    event = "VeryLazy",
    config = true
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

      map("n", "<leader>m", function() harpoon:list():add() end)
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
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    keys = { "<leader>ti" },
    config = function()
      ---@module "ibl"
      ---@type ibl.config
      local opts = {
        enabled = false,
      }

      require("ibl").setup(opts)

      vim.keymap.set("n", "<leader>ti", function()
        vim.cmd("IBLToggle")
      end)
    end,
  },
  "almo7aya/openingh.nvim",
  {
    'MagicDuck/grug-far.nvim',
    keys = {
      {
        "<leader>fr",
        function() require('grug-far').toggle_instance({ instanceName = "far", staticTitle = "Find and Replace" }) end
      }
    },
    opts = {},
  },
  {
    "hat0uma/csvview.nvim",
    ---@module "csvview"
    ---@type CsvView.Options
    opts = {},
    cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
  }
  -- {
  --   "folke/snacks.nvim",
  --   ---@type snacks.Config
  --   opts = {
  --     lazygit = {
  --       win = {
  --         style = {
  --           border = "rounded"
  --         }
  --       }
  --     }
  --   }
  -- }
  -- {
  --   "m4xshen/hardtime.nvim",
  --   lazy = false,
  --   -- enabled = false,
  --   dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
  --   opts = {
  --   --   -- callback = require('notify')
  --   },
  --   -- config = function()
  --   --   require("hardtime").setup({
  --   --     callback = function(text)
  --   --       vim.notify(
  --   --         "FDJSKLFJFLKSJKFLJKLF",
  --   --         vim.log.levels.WARN,
  --   --         { title = "dsafasf", }
  --   --       )
  --   --     end,
  --   --   })
  --   -- end
  -- },
}
