local ok, harpoon = pcall(require, "harpoon")
if not ok then
  return
end

harpoon.setup {}

local nmap = function(tbl)
  vim.keymap.set("n", tbl[1], tbl[2], tbl[3])
end

nmap { "<leader>m", require("harpoon.mark").add_file }
nmap { "<C-e>", require("harpoon.ui").toggle_quick_menu }

nmap { "<leader>h", function() require("harpoon.ui").nav_file(1) end }
nmap { "<leader>j", function() require("harpoon.ui").nav_file(2) end }
nmap { "<leader>k", function() require("harpoon.ui").nav_file(3) end }
nmap { "<leader>l", function() require("harpoon.ui").nav_file(4) end }

for i = 1, 9 do
  vim.keymap.set("n", string.format("<leader>%s", i), function() require("harpoon.ui").nav_file(i) end)
end
