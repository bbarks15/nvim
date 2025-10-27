return {
  {
    'dmtrKovalenko/fff.nvim',
    build = 'rustup run nightly cargo build --release',
    -- or if you are using nixos
    -- build = "nix run .#release",
    opts = {
      debug = {
        enabled = true, -- we expect your collaboration at least during the beta
      },
      preview = {
        enabled = false,
      },
      layout = {
        height = 0.5,
        width = 0.5,
        prompt_position = 'top',
        preview_position = 'right',
        preview_size = 0.5,
      },
    },
    -- No need to lazy-load with lazy.nvim.
    -- This plugin initializes itself lazily.
    lazy = false,
  }
}
