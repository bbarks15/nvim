-- Git related plugins
return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {},
    config = function()
      require("gitsigns").setup({
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local map = require("helpers.keys").map

          map("n", "<leader>tb", gs.toggle_current_line_blame)
          map("n", "<leader>gb", function()
            gs.blame_line({ full = true })
          end)
          map("n", "<leader>gp", gs.preview_hunk)
          map("n", "<leader>gu", gs.reset_hunk)
        end,
      })
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    config = function()
      local map = require("helpers.keys").map
      map("n", "<leader>G", "<CMD>LazyGit<CR>")
    end,
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional - Diff integration
      "nvim-telescope/telescope.nvim", -- optional
    },
    config = true
  },
  { "tpope/vim-fugitive" }
}
