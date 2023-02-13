local status, neotest = pcall(require, "neotest")
if (not status) then return end

neotest.setup({
  log_level = 5,
  adapters = {
    require("neotest-dotnet"),
    require("neotest-rust"),
    require('neotest-jest')({
      jestCommand = "npm test --"
    }),
  },
})

vim.keymap.set("n", "<leader>tt", function()
  require("neotest").summary.toggle()
  require("neotest").output_panel.toggle()
end)
vim.keymap.set("n", "<leader>to", function() require("neotest").output.open({ enter = true }) end)
vim.keymap.set("n", "<leader>tf", function() require('neotest').run.run(vim.fn.expand("%")) end)
vim.keymap.set("n", "<leader>tl", require('neotest').run.run_last)
vim.keymap.set("n", "<leader>tr", require("neotest").run.run)
vim.keymap.set("n", "<leader>ts", require("neotest").run.stop)

