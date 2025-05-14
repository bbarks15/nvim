return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false,
    opts = {
      -- claude = {
      --   model = "claude-3-5-sonnet-20241022",
      --   max_tokens = 4096,
      -- },
      windows = {
        sidebar_header = { enabled = false, },
      }
    },
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      -- "echasnovski/mini.pick",         -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      -- "ibhagwan/fzf-lua",              -- for file_selector provider fzf
      "nvim-tree/nvim-web-devicons",   -- or echasnovski/mini.icons
      {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = { file_types = { "Avante" }, },
        ft = { "Avante" },
      },
    }
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
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
    file_types = {
      yaml = true
    },
    copilot_model = "gpt-4o-copilot",
  }
}
