- [ ] Drop LuaSnip — blink.cmp has built-in snippet support via vim.snippet, loads friendly-snippets natively. Convert snippets/react.lua to VSCode JSON format.
- [ ] Clean up commented-out code across plugin files (lsp.lua, file.lua, themes.lua, options.lua)

## Plugins to add
- [ ] folke/which-key.nvim — shows keybinding popup as you type, works automatically with existing desc fields

## Plugins to consider replacing
- [ ] alpha-nvim → snacks.nvim dashboard — current alpha config is ~200 lines, snacks provides dashboard + 30 other utilities (notifications, lazygit, smooth scroll, indent guides)
- [ ] telescope.nvim → snacks.picker or fzf-lua — faster alternatives

## Config improvements
- [ ] Trim Telescope file_ignore_patterns — most are already covered by .gitignore, only need non-gitignored patterns like .svg$
