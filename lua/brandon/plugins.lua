local status, packer = pcall(require, "packer")
if (not status) then
  print("Packer is not installed")
  return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'nvim-lualine/lualine.nvim' -- Statusline
  use 'nvim-lua/plenary.nvim' -- Common utilities
  use 'onsails/lspkind-nvim' -- vscode-like pictograms
  use 'nvim-lua/lsp_extensions.nvim'
  use 'hrsh7th/cmp-buffer' -- nvim-cmp source for buffer words
  use 'hrsh7th/cmp-nvim-lsp' -- nvim-cmp source for neovim's built-in LSP
  use 'hrsh7th/nvim-cmp' -- Completion
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'neovim/nvim-lspconfig' -- LSP
  use 'jose-elias-alvarez/null-ls.nvim' -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'simrat39/rust-tools.nvim'

  use 'ThePrimeagen/harpoon'

  use 'nvim-tree/nvim-tree.lua'
  use 'kylechui/nvim-surround'

  use 'glepnir/lspsaga.nvim' -- LSP UIs
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use "rafamadriz/friendly-snippets"
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }
  use 'nvim-treesitter/nvim-treesitter-context'
  use 'JoosepAlviste/nvim-ts-context-commentstring'
  use 'kyazdani42/nvim-web-devicons' -- File icons
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'
  use { 'nvim-telescope/telescope-fzf-native.nvim',
    run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release; cmake --build build --config Release; cmake --install build --prefix build' }
  use 'windwp/nvim-autopairs'
  use 'windwp/nvim-ts-autotag'
  use 'norcalli/nvim-colorizer.lua'
  use 'folke/zen-mode.nvim'
  use 'akinsho/nvim-bufferline.lua'
  use 'goolord/alpha-nvim'

  use 'lewis6991/gitsigns.nvim'
  use 'numToStr/Comment.nvim'
  use 'folke/todo-comments.nvim'
  use 'folke/trouble.nvim'
  use { 'embark-theme/vim', as = 'embark' }
  use { 'rose-pine/neovim', as = 'rose-pine' }
  use 'rebelot/kanagawa.nvim'
  use 'lewis6991/impatient.nvim'
  -- use {
  --   'nvim-neotest/neotest',
  --   requires = {
  --     {
  --       'Issafalcon/neotest-dotnet',
  --       'rouge8/neotest-rust',
  --       'antoinemadec/FixCursorHold.nvim'
  --     },
  --   }
  -- },
  use {
    "klen/nvim-test",
    config = function()
      require('nvim-test').setup()
    end
  }
end)
