return {
  {
    'dmtrKovalenko/fff.nvim',
    enabled = false,
    build = function()
      -- this will download prebuild binary or try to use existing rustup toolchain to build from source
      -- (if you are using lazy you can use gb for rebuilding a plugin if needed)
      require("fff.download").download_or_build_binary()
    end,
    opts = {
      debug = {
        enabled = true, -- we expect your collaboration at least during the beta
      },
      preview = {
        enabled = false,
      },
      layout = {
        -- height = 0.5,
        -- width = 0.5,
        -- prompt_position = 'top',
        -- preview_position = 'right',
        -- preview_size = 0.5,
      },
    },
    keys = {
      {
        "<C-P>", -- try it if you didn't it is a banger keybinding for a picker
        function() require('fff').find_files() end,
        desc = 'FFFind files',
      },
      {
        "<leader>F",
        function() require('fff').live_grep() end,
        desc = 'LiFFFe grep',
      },
      {
        "fc",
        function() require('fff').live_grep({ query = vim.fn.expand("<cword>") }) end,
        desc = 'Search current word',
      },
    },
    -- No need to lazy-load with lazy.nvim.
    -- This plugin initializes itself lazily.
    lazy = false,
  }
}
