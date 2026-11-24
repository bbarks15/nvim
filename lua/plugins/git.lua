-- Git related plugins
return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      on_attach = function(bufnr)
        local gs = require('gitsigns')

        vim.keymap.set("n", "<leader>tb", gs.toggle_current_line_blame,
          { buffer = bufnr, silent = true, desc = "Toggle line blame" })
        vim.keymap.set("n", "<leader>gb", function()
          gs.blame_line({ full = true })
        end, { buffer = bufnr, silent = true, desc = "Blame line (full)" })
        vim.keymap.set("n", "<leader>gp", gs.preview_hunk, { buffer = bufnr, silent = true, desc = "Preview hunk" })
        vim.keymap.set("n", "<leader>gu", gs.reset_hunk, { buffer = bufnr, silent = true, desc = "Reset hunk" })
      end,
    },
  },
}
