local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

return require("lazy").setup({
	-- general
	"ThePrimeagen/harpoon",
	"folke/neodev.nvim",
	"folke/zen-mode.nvim",
	"github/copilot.vim",
	"jamessan/vim-gnupg",
	"lewis6991/gitsigns.nvim",
	"lukas-reineke/indent-blankline.nvim",
	"mbbill/undotree",
	"sainnhe/gruvbox-material",
	"tpope/vim-commentary",
	"tpope/vim-fugitive",
	"tpope/vim-repeat",
	"tpope/vim-surround",
	"tpope/vim-unimpaired",

	-- telescope
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.2",
		dependencies = {
			"nvim-telescope/telescope-live-grep-args.nvim",
			"nvim-lua/plenary.nvim",
		},
	},

	-- treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	},
	"nvim-treesitter/nvim-treesitter-context",

	-- lsp
	"neovim/nvim-lspconfig",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"mhartington/formatter.nvim",

	-- autocompletion
	"davidsierradz/cmp-conventionalcommits",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-nvim-lsp-signature-help",
	"hrsh7th/cmp-nvim-lua",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-vsnip",
	"hrsh7th/nvim-cmp",
	"hrsh7th/vim-vsnip",
	"saadparwaiz1/cmp_luasnip",

	-- debugging
	"mfussenegger/nvim-dap",
	"mfussenegger/nvim-dap-python",
	"rcarriga/nvim-dap-ui",
	"theHamsta/nvim-dap-virtual-text",
})
