-- Git related plugins
return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      on_attach = function(_)
        local gs = package.loaded.gitsigns

        local map = require("helpers.keys").map

        map("n", "<leader>tb", gs.toggle_current_line_blame)
        map("n", "<leader>gb", function()
          gs.blame_line({ full = true })
        end)
        map("n", "<leader>gp", gs.preview_hunk)
        map("n", "<leader>gu", gs.reset_hunk)
      end,
    },
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = { "nvim-lua/plenary.nvim", },
    keys = { { "<leader>G", "<cmd>LazyGit<cr>", desc = "LazyGit" } },
    lazy = true
  },
  { "tpope/vim-fugitive" },
  {
    "sindrets/diffview.nvim",
    opts = {
      view = {
        merge_tool = {
          -- Config for conflicted files in diff views during a merge or rebase.
          layout = "diff3_mixed",
        },
      }
    }
  }
}
