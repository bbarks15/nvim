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
    keys = {
      { "<leader>m", function() require("harpoon"):list():add() end,     desc = "Harpoon add" },
      {
        "<C-e>",
        function()
          local h = require("harpoon")
          h.ui:toggle_quick_menu(h:list())
        end,
        desc = "Harpoon menu"
      },
      { "<leader>h", function() require("harpoon"):list():select(1) end, desc = "Harpoon 1" },
      { "<leader>j", function() require("harpoon"):list():select(2) end, desc = "Harpoon 2" },
      { "<leader>k", function() require("harpoon"):list():select(3) end, desc = "Harpoon 3" },
      { "<leader>l", function() require("harpoon"):list():select(4) end, desc = "Harpoon 4" },
      { "<leader>1", function() require("harpoon"):list():select(1) end, desc = "Harpoon 1" },
      { "<leader>2", function() require("harpoon"):list():select(2) end, desc = "Harpoon 2" },
      { "<leader>3", function() require("harpoon"):list():select(3) end, desc = "Harpoon 3" },
      { "<leader>4", function() require("harpoon"):list():select(4) end, desc = "Harpoon 4" },
      { "<leader>5", function() require("harpoon"):list():select(5) end, desc = "Harpoon 5" },
      { "<leader>6", function() require("harpoon"):list():select(6) end, desc = "Harpoon 6" },
      { "<leader>7", function() require("harpoon"):list():select(7) end, desc = "Harpoon 7" },
      { "<leader>8", function() require("harpoon"):list():select(8) end, desc = "Harpoon 8" },
      { "<leader>9", function() require("harpoon"):list():select(9) end, desc = "Harpoon 9" },
    },
    config = function()
      require("harpoon"):setup()
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    keys = {
      { "<leader>ti", "<cmd>IBLToggle<cr>", desc = "Toggle indent lines" },
    },
    opts = {
      enabled = false,
    },
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
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    enabled = false,
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  }
}
