return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use('folke/which-key.nvim')
  use('folke/zen-mode.nvim')
  use('github/copilot.vim')
  use('jamessan/vim-gnupg')
  use('lukas-reineke/indent-blankline.nvim')
  use('mbbill/undotree')
  use('mfussenegger/nvim-dap')
  use('p00f/nvim-ts-rainbow')
  use('rcarriga/nvim-dap-ui')
  use('sainnhe/gruvbox-material')
  use('tpope/vim-commentary')
  use('tpope/vim-fugitive')
  use('tpope/vim-surround')

  use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
  use('nvim-treesitter/nvim-treesitter-context')

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    -- or                            , branch = '0.1.x',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },
      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
    }
  }

  use({
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require("null-ls").setup()
    end,
    requires = { "nvim-lua/plenary.nvim" },
  })

  use({
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  })

end)
