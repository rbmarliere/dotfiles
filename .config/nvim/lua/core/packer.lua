return require("packer").startup(function(use)
  use("wbthomason/packer.nvim")

  -- general
  use("folke/neodev.nvim")
  use("folke/zen-mode.nvim")
  use("github/copilot.vim")
  use("jamessan/vim-gnupg")
  use("lewis6991/gitsigns.nvim")
  use("lukas-reineke/indent-blankline.nvim")
  use("mbbill/undotree")
  use("sainnhe/gruvbox-material")
  use("tpope/vim-commentary")
  use("tpope/vim-fugitive")
  use("tpope/vim-repeat")
  use("tpope/vim-surround")
  use("tpope/vim-unimpaired")

  use {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.1",
    requires = {
      { "nvim-telescope/telescope-live-grep-args.nvim" },
      { "nvim-lua/plenary.nvim" }
    },
    config = function()
      require("telescope").load_extension("live_grep_args")
    end
  }

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
  use("jose-elias-alvarez/null-ls.nvim")

  -- autocompletion
  use("davidsierradz/cmp-conventionalcommits")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-cmdline")
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-nvim-lsp-signature-help")
  use("hrsh7th/cmp-nvim-lua")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-vsnip")
  use("hrsh7th/nvim-cmp")
  use("hrsh7th/vim-vsnip")
  use("saadparwaiz1/cmp_luasnip")

  -- debugging
  use("mfussenegger/nvim-dap")
  use("mfussenegger/nvim-dap-python")
  use("rcarriga/nvim-dap-ui")
  use("theHamsta/nvim-dap-virtual-text")
end)
