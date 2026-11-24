return {
  {
    'dmtrKovalenko/fff',
    build = function()
      -- this will download prebuild binary or try to use existing rustup toolchain to build from source
      -- (if you are using lazy you can use gb for rebuilding a plugin if needed)
      require("fff.download").download_or_build_binary()
    end,
    opts = {
      preview = {
        enabled = false,
      },
      layout = {
        height = 0.5,
        width = 0.5,
        prompt_position = 'top',
      },
    },
    keys = {
      {
        "<C-P>",
        function() require('fff').find_files() end,
        desc = 'FFFind files',
      },
      {
        "<leader>F",
        function() require('fff').live_grep() end,
        desc = 'LiFFFe grep',
      },
      {
        "<leader>fc",
        function() require('fff').live_grep_under_cursor() end,
        mode = { 'n', 'x' },
        desc = 'Search current word / selection',
      },
    },
    -- No need to lazy-load with lazy.nvim.
    -- This plugin initializes itself lazily.
    lazy = false,
  }
}
