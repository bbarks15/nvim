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
  use 'hrsh7th/cmp-buffer' -- nvim-cmp source for buffer words
  use 'hrsh7th/cmp-nvim-lsp' -- nvim-cmp source for neovim's built-in LSP
  use 'hrsh7th/nvim-cmp' -- Completion
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'neovim/nvim-lspconfig' -- LSP
  use 'jose-elias-alvarez/null-ls.nvim' -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'simrat39/rust-tools.nvim'
  use 'simrat39/inlay-hints.nvim'
  use 'simrat39/symbols-outline.nvim'
  use 'j-hui/fidget.nvim'

  use 'lewis6991/impatient.nvim'

  use 'kylechui/nvim-surround'
  use 'windwp/nvim-autopairs'
  use 'windwp/nvim-ts-autotag'
  use 'numToStr/Comment.nvim'
  use 'folke/todo-comments.nvim'
  use 'folke/trouble.nvim'
  use 'ThePrimeagen/harpoon'

  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use "rafamadriz/friendly-snippets"

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }
  use 'nvim-treesitter/nvim-treesitter-context'
  use 'JoosepAlviste/nvim-ts-context-commentstring'

  use 'nvim-telescope/telescope.nvim'
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  use 'kyazdani42/nvim-web-devicons' -- File icons
  use 'norcalli/nvim-colorizer.lua'
  use 'goolord/alpha-nvim'
  use 'akinsho/bufferline.nvim'
  use 'lewis6991/gitsigns.nvim'

  use {
    'nvim-neotest/neotest',
    requires = { {
      'Issafalcon/neotest-dotnet',
      'rouge8/neotest-rust',
      'antoinemadec/FixCursorHold.nvim'
    } }
  }

  use { 'embark-theme/vim', as = 'embark' }
  use { 'rose-pine/neovim', as = 'rose-pine' }
  use 'rebelot/kanagawa.nvim'
  use 'folke/tokyonight.nvim'
  use "EdenEast/nightfox.nvim"
end)
