-- Fancier statusline
return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      icons_enabled = true,
      section_separators = { left = "", right = "" },
      component_separators = "|",
      disabled_filetypes = { "packer", "NvimTree", "alpha", "neo-tree" },
    },
    sections = {
      lualine_a = { { "mode", separator = { left = "", right = "" }, right_padding = 2 } },
      -- lualine_a = { { "mode", right_padding = 2 } },
      -- lualine_b = { "branch" },
      lualine_b = {},
      lualine_c = {
        {
          "filename",
          file_status = true, -- displays file status (readonly status, modified status)
          path = 1,           -- 0 = just filename, 1 = relative path, 2 = absolute path
        },
      },
      lualine_x = {
        'branch',
        {
          "diagnostics",
          sources = { "nvim_diagnostic" },
          symbols = { error = " ", warn = " ", info = " ", hint = " " },
        },
        -- "filetype",
      },
      -- lualine_y = { "progress" },
      lualine_y = {},
      -- lualine_z = { { "location", separator = { right = "" }, left_padding = 2 } },
      lualine_z = {},
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {
        {
          "filename",
          file_status = true, -- displays file status (readonly status, modified status)
          path = 1,
        },
      },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    extensions = { "fugitive" },
  }
}
