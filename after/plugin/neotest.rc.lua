local status, neotest = pcall(require, "neotest")
if (not status) then return end

neotest.setup({
  log_level = 0,
  adapters = {
    require("neotest-dotnet"),
    require("neotest-rust")
  },
})
