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
					["clangd"] = function()
						lspconfig["clangd"].setup({
							cmd = { "clangd", "--offset-encoding=utf-16" },
						})
					end,
					-- ["ruff_lsp"] = function()
					-- 	lspconfig["ruff_lsp"].setup({
					-- 		settings = {
					-- 			interpreter = vim.fn.getcwd() .. "/.venv/bin/python",
					-- 		},
					-- 	})
					-- end,
					-- ["pyright"] = function()
					-- 	lspconfig["pyright"].setup({
					-- 		settings = {
					-- 			pyright = {
					-- 				disableOrganizeImports = true,
					-- 			},
					-- 			python = {
					-- 				pythonPath = vim.fn.getcwd() .. "/.venv/bin/python",
					-- 				analysis = {
					-- 					typeCheckingMode = "off",
					-- 				},
					-- 			},
					-- 		},
					-- 	})
					-- end,
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
					["rust_analyzer"] = function()
						lspconfig["rust_analyzer"].setup({
							on_attach = function(_, bufnr)
								vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
							end,
							settings = {
								["rust-analyzer"] = {
									imports = {
										granularity = {
											group = "module",
										},
										prefix = "self",
									},
									cargo = {
										buildScripts = {
											enable = true,
										},
									},
									procMacro = {
										enable = true,
									},
									inlayHints = {
										typeHints = {
											enable = false,
										},
									},
								},
							},
						})
					end,
				})
				vim.api.nvim_create_autocmd("LspAttach", {
					-- https://github.com/mrcjkb/rustaceanvim/discussions/135
					callback = function(args)
						local client = vim.lsp.get_client_by_id(args.data.client_id)
						if client then
							client.server_capabilities.semanticTokensProvider = nil
						end
					end,
				})
			end,
		},
		{
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			opts = {
				ensure_installed = {
					"bash-language-server",
					"black",
					"clangd",
					"codelldb",
					"codespell",
					"cpptools",
					"goimports",
					"gopls",
					"lua-language-server",
					"prettier",
					"ruff-lsp",
					"rust-analyzer",
					"shfmt",
					"stylua",
					"taplo",
					"typescript-language-server",
					"vale",
				},
				run_on_start = false,
			},
			config = function(_, opts)
				local mason_tool_installer = require("mason-tool-installer")
				mason_tool_installer.setup(opts)
				vim.api.nvim_create_autocmd("User", {
					pattern = "MasonToolsUpdateCompleted",
					callback = function(e)
						vim.schedule(function()
							local cmd =
								"~/.local/share/nvim/mason/packages/vale/vale --config=$HOME/.config/vale/.vale.ini sync"
							vim.fn.system(cmd)
						end)
					end,
				})
			end,
		},
	},
}
