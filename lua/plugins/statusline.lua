-- Fancier statusline
local icons = require("core.icons")

local filename = {
  "filename",
  file_status = true, -- displays file status (readonly / modified)
  path = 1,           -- 0 = just filename, 1 = relative path, 2 = absolute path
}

return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      icons_enabled = true,
      section_separators = { left = "", right = "" },
      component_separators = "|",
      disabled_filetypes = { "packer", "NvimTree", "alpha", "neo-tree", "Avante", "AvanteInput", "AvanteSelectedFiles" },
    },
    sections = {
      lualine_a = { { "mode", right_padding = 2 } },
      lualine_b = {},
      lualine_c = { filename },
      lualine_x = {
        "branch",
        {
          "diagnostics",
          sources = { "nvim_diagnostic" },
          symbols = { error = icons.diagnostics.Error .. " ", warn = icons.diagnostics.Warning .. " ", info = icons.diagnostics.Information .. " ", hint = icons.diagnostics.Hint .. " " },
        },
      },
      lualine_y = {},
      lualine_z = {},
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { filename },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
    extensions = { "fugitive" },
  }
}
