local status, ts = pcall(require, "nvim-treesitter.configs")
if (not status) then return end

require 'nvim-treesitter.install'.compilers = { "clang", "gcc" }

ts.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
    disable = {},
  },
  ensure_installed = {
    "tsx",
    "json",
    "css",
    "html",
    "lua",
    "typescript",
    "javascript",
    "c_sharp",
    "rust",
  },
  autotag = {
    enable = true,
  },
  context_commentstring = {
    enable = true
  },
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
