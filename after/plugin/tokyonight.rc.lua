local status, tokyo = pcall(require, "tokyonight")
if (not status) then return end

tokyo.setup({
  style = "night"
})

vim.cmd('colo tokyonight')
