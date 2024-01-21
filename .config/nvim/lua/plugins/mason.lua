return {
	"williamboman/mason.nvim",
	opts = {
		ui = {
			border = "none",
		},
		-- log_level = vim.log.levels.DEBUG,
	},
	dependencies = {
		{
			"williamboman/mason-lspconfig.nvim",
			config = function()
				require("neodev").setup()
				local lspconfig = require("lspconfig")
				require("mason-lspconfig").setup_handlers({
					function(server_name)
						lspconfig[server_name].setup({})
					end,
					["ruff_lsp"] = function()
						lspconfig["ruff_lsp"].setup({
							settings = {
								interpreter = vim.fn.getcwd() .. "/.venv/bin/python",
							},
						})
					end,
					["pyright"] = function()
						lspconfig["pyright"].setup({
							settings = {
								pyright = {
									disableOrganizeImports = true,
								},
								python = {
									pythonPath = vim.fn.getcwd() .. "/.venv/bin/python",
									analysis = {
										typeCheckingMode = "off",
									},
								},
							},
						})
					end,
					["lua_ls"] = function()
						lspconfig["lua_ls"].setup({
							settings = {
								Lua = {
									workspace = {
										checkThirdParty = false,
									},
								},
							},
						})
					end,
				})
			end,
		},
	},
}