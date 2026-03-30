-- Git related plugins
return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      on_attach = function(_)
        local gs = require('gitsigns')

        vim.keymap.set("n", "<leader>tb", gs.toggle_current_line_blame, { silent = true, desc = "Toggle line blame" })
        vim.keymap.set("n", "<leader>gb", function()
          gs.blame_line({ full = true })
        end, { silent = true, desc = "Blame line (full)" })
        vim.keymap.set("n", "<leader>gp", gs.preview_hunk, { silent = true, desc = "Preview hunk" })
        vim.keymap.set("n", "<leader>gu", gs.reset_hunk, { silent = true, desc = "Reset hunk" })
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
