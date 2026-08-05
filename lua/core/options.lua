vim.opt.title = true
vim.opt.smartindent = true
vim.opt.backup = false
vim.opt.backupskip = { '/tmp/*', '/private/tmp/*' }
vim.opt.inccommand = 'split'
vim.opt.breakindent = true
vim.opt.path:append('**') -- Finding files - Search down into subfolders

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.laststatus = 3
vim.opt.scrolloff = 8
vim.opt.formatoptions = "tqn"
vim.opt.wrap = false
vim.opt.sidescroll = 5
vim.opt.linebreak = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.signcolumn = 'yes'
vim.opt.swapfile = false
vim.opt.updatetime = 50

vim.opt.clipboard:append('unnamedplus')

vim.cmd([[let &fcs="eob: "]])

vim.cmd('autocmd Filetype cs setlocal tabstop=4 shiftwidth=4')

vim.api.nvim_create_autocmd('TextYankPost', {
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
vim.opt.termguicolors = true
vim.opt.pumblend = 5

vim.cmd.colorscheme "tokyonight-day"
