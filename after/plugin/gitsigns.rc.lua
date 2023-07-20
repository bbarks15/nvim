local status, gitsigns = pcall(require, "gitsigns")
if (not status) then return end

gitsigns.setup {
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    map('n', '<leader>tb', gs.toggle_current_line_blame)
    map('n', '<leader>gb', function() gs.blame_line { full = true } end)
    map('n', '<leader>gp', gs.preview_hunk)
    map('n', '<leader>gr', gs.reset_hunk)
    map('n', '<leader>gs', gs.stage_hunk)
    map('n', '<leader>gu', gs.undo_stage_hunk)
  end
}
