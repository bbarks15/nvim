local header = table.concat({
  "       ▄▀▀▀▀▀▀▀▀▀▀▄▄           ",
  "     ▄▀▀░░░░░░░░░░░░░▀▄        ",
  "   ▄▀░░░░░░░░░░░░░░░░░░▀▄      ",
  "   █░░░░░░░░░░░░░░░░░░░░░▀▄    ",
  "  ▐▌░░░░░░░░▄▄▄▄▄▄▄░░░░░░░▐▌   ",
  "  █░░░░░░░░░░░▄▄▄▄░░▀▀▀▀▀░░█   ",
  " ▐▌░░░░░░░▀▀▀▀░░░░░▀▀▀▀▀░░░▐▌  ",
  " █░░░░░░░░░▄▄▀▀▀▀▀░░░░▀▀▀▀▄░█  ",
  " █░░░░░░░░░░░░░░░░▀░░░▐░░░░░▐▌ ",
  " ▐▌░░░░░░░░░▐▀▀██▄░░░░░░▄▄▄░▐▌ ",
  "  █░░░░░░░░░░░▀▀▀░░░░░░▀▀██░░█ ",
  "  ▐▌░░░░▄░░░░░░░░░░░░░▌░░░░░░█ ",
  "   ▐▌░░▐░░░░░░░░░░░░░░▀▄░░░░░█ ",
  "    █░░░▌░░░░░░░░▐▀░░░░▄▀░░░▐▌ ",
  "    ▐▌░░▀▄░░░░░░░░▀░▀░▀▀░░░▄▀  ",
  "    ▐▌░░▐▀▄░░░░░░░░░░░░░░░░█   ",
  "    ▐▌░░░▌░▀▄░░░░▀▀▀▀▀▀░░░█    ",
  "    █░░░▀░░░░▀▄░░░░░░░░░░▄▀    ",
  "   ▐▌░░░░░░░░░░▀▄░░░░░░▄▀      ",
  "  ▄▀░░░▄▀░░░░░░░░▀▀▀▀█▀        ",
  " ▀░░░▄▀░░░░░░░░░░▀░░░▀▀▀▀▄▄▄▄▄ ",
}, "\n")

return {
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    ---@type snacks.Config
    opts = {
      dashboard = {
        enabled = true,
        width = 50,
        autokeys = "0123456789abcdefghijklmnopqrstuvwxyz",
        preset = { header = header },
        formats = {
          icon = function(item)
            if item.icon ~= "file" then
              return { item.icon, width = 2, hl = "icon" }
            end
            local icon, hl = require("nvim-web-devicons").get_icon(item.file, vim.fn.fnamemodify(item.file, ":e"),
              { default = true })
            return { icon, width = 3, hl = hl }
          end,
          file = function(item)
            local fname = vim.fn.fnamemodify(item.file, ":.")
            if #fname > 35 then
              local Path = require("plenary.path")
              fname = Path:new(fname):shorten(1, { -2, -1 })
              if #fname > 35 then
                fname = Path:new(fname):shorten(1, { -1 })
              end
            end
            local dir, file = fname:match("^(.*/)(.+)$")
            return dir and { { dir, hl = "Comment" }, { file, hl = "Normal" } } or { { fname, hl = "Normal" } }
          end,
          key = { "%s", hl = "Keyword" },
        },
        sections = {
          { section = "header", padding = 2 },
          { title = "Recent files", align = "center", padding = 1 },
          {
            section = "recent_files",
            cwd = true,
            limit = 10,
            filter = function(file)
              return not file:find("COMMIT_EDITMSG", 1, true)
            end,
          },
        },
      },
      lazygit = {
        win = { border = true, backdrop = false },
      },
      gitbrowse = {},
    },
    keys = {
      { "<leader>G", function() Snacks.lazygit() end, desc = "LazyGit" },
      { "<leader>go", function() Snacks.gitbrowse() end, mode = { "n", "x" }, desc = "Open in browser" },
      {
        "<leader>gy",
        function()
          Snacks.gitbrowse({
            notify = false,
            open = function(url)
              vim.fn.setreg("+", url)
              vim.notify("Copied " .. url)
            end,
          })
        end,
        mode = { "n", "x" },
        desc = "Copy git URL",
      },
    },
  },
}
