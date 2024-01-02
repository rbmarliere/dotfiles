return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"folke/neodev.nvim",
		"hrsh7th/nvim-cmp",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		require("lspconfig.ui.windows").default_options.border = "none"
	end,
}
