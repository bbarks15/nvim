local status, packer = pcall(require, "packer")
if (not status) then
  print("Packer is not installed")
  return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'nvim-lualine/lualine.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'onsails/lspkind-nvim'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'neovim/nvim-lspconfig'
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'jose-elias-alvarez/typescript.nvim'
  use {
    "pmizio/typescript-tools.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig"
    },
  }
  use {
    'mrcjkb/haskell-tools.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
    branch = '1.x.x',
  }
  use 'simrat39/inlay-hints.nvim'
  use {
    'j-hui/fidget.nvim',
    tag = 'legacy',
  }
  use 'danymat/neogen'

  use 'lewis6991/impatient.nvim'

  use 'kylechui/nvim-surround'
  use 'windwp/nvim-autopairs'
  use 'windwp/nvim-ts-autotag'
  use 'numToStr/Comment.nvim'
  use 'folke/todo-comments.nvim'
  use 'folke/trouble.nvim'
  use 'ThePrimeagen/harpoon'
  use 'kevinhwang91/nvim-bqf'

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
  use 'NvChad/nvim-colorizer.lua'
  use 'goolord/alpha-nvim'
  use 'akinsho/bufferline.nvim'
  use 'lewis6991/gitsigns.nvim'
  use 'tpope/vim-fugitive'
  use 'kdheepak/lazygit.nvim'
  use 'nvim-tree/nvim-tree.lua'

  use {
    'nvim-neotest/neotest',
    requires = { {
      'Issafalcon/neotest-dotnet',
      'rouge8/neotest-rust',
      'haydenmeade/neotest-jest',
      'antoinemadec/FixCursorHold.nvim'
    } }
  }

  use { 'embark-theme/vim', as = 'embark' }
  use { 'rose-pine/neovim', as = 'rose-pine' }
  use { "catppuccin/nvim", as = "catppuccin" }
  use 'rebelot/kanagawa.nvim'
  use 'folke/tokyonight.nvim'
  use "EdenEast/nightfox.nvim"
  use "olivercederborg/poimandres.nvim"
  use {
    "jesseleite/nvim-noirbuddy",
    requires = { "tjdevries/colorbuddy.nvim", branch = "dev" }
  }
end)
