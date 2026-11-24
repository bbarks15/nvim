vim.opt.title = true
vim.opt.inccommand = 'split'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.foldlevelstart = 99
vim.opt.breakindent = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.laststatus = 3
require("core.statusline").setup()
vim.opt.scrolloff = 8
vim.opt.wrap = false
vim.opt.sidescroll = 5
vim.opt.linebreak = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.signcolumn = 'yes'
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.winborder = 'single'

require('vim._core.ui2').enable()

vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

vim.opt.fillchars = { eob = ' ' }

vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

local hotreload = vim.api.nvim_create_augroup('hotreload', { clear = true })

vim.api.nvim_create_autocmd(
  { 'FocusGained', 'TermLeave', 'BufEnter', 'WinEnter', 'CursorHold', 'CursorHoldI' },
  {
    group = hotreload,
    callback = function()
      local mode = vim.api.nvim_get_mode().mode
      if mode:match('[cR!s]') or vim.fn.getcmdwintype() ~= '' then return end
      vim.cmd('checktime')
    end,
  }
)

vim.api.nvim_create_autocmd('FileChangedShellPost', {
  group = hotreload,
  callback = function(args)
    vim.notify(
      ('Reloaded: %s'):format(vim.fn.fnamemodify(args.file, ':~:.')),
      vim.log.levels.INFO
    )
  end,
})

vim.opt.cursorline = true
vim.opt.pumblend = 5

vim.cmd.colorscheme "catppuccin-nvim"
