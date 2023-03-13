return require("packer").startup(function(use)
  use("wbthomason/packer.nvim")

  -- general
  use("folke/zen-mode.nvim")
  use("github/copilot.vim")
  use("jamessan/vim-gnupg")
  use("lukas-reineke/indent-blankline.nvim")
  use("mbbill/undotree")
  use("mfussenegger/nvim-dap")
  use("rcarriga/nvim-dap-ui")
  use("sainnhe/gruvbox-material")
  use("tpope/vim-commentary")
  use("tpope/vim-fugitive")
  use("tpope/vim-surround")
  use({
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  })
  use({
    "nvim-telescope/telescope.nvim",
    tag = "0.1.0",
    -- or                            , branch = "0.1.x",
    requires = { "nvim-lua/plenary.nvim" },
  })


  -- treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
  }
  use("nvim-treesitter/nvim-treesitter-context")

  -- lsp
  use("neovim/nvim-lspconfig")
  use("williamboman/mason.nvim")
  use("williamboman/mason-lspconfig.nvim")

  -- autocompletion
  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use("saadparwaiz1/cmp_luasnip")
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-nvim-lua")
  use("hrsh7th/cmp-vsnip")
  use("hrsh7th/vim-vsnip")
  use("hrsh7th/cmp-nvim-lsp-signature-help")
  use("davidsierradz/cmp-conventionalcommits")
end)
