local status, bqf = pcall(require, "bqf")
if (not status) then return end

bqf.setup({
  preview = { winblend = 0 }
})
