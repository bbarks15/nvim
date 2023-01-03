vim.cmd("autocmd!")

vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.shell = 'fish'
vim.opt.backupskip = { '/tmp/*', '/private/tmp/*' }
vim.opt.inccommand = 'split'
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.backspace = { 'start', 'eol', 'indent' }
vim.opt.path:append { '**' } -- Finding files - Search down into subfolders
vim.opt.wildignore:append { '*/node_modules/*' }

vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.laststatus = 2
vim.opt.scrolloff = 8
vim.opt.hlsearch = false
vim.opt.wildmode = { 'longest', 'list', 'full' }
vim.opt.formatoptions = "tqn"
-- vim.opt.textwidth = 80
vim.opt.wrap = false -- No Wrap lines
-- vim.opt.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
vim.opt.splitbelow = true
vim.opt.splitright = true
-- vim.opt.startofline = true
vim.opt.conceallevel = 1
vim.opt.signcolumn = 'yes'
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.updatetime = 50

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

vim.cmd([[let &fcs="eob: "]])

vim.cmd('colo embark')

vim.cmd('autocmd Filetype cs setlocal tabstop=4 shiftwidth=4')
