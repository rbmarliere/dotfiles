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
			dependencies = {
				"saghen/blink.cmp",
				"neovim/nvim-lspconfig",
			},
			config = function()
				require("lspconfig.ui.windows").default_options.border = "none"
				vim.diagnostic.config({
					virtual_text = false,
				})
				-- vim.lsp.set_log_level("DEBUG")

				local lspconfig = require("lspconfig")
				require("mason-lspconfig").setup_handlers({
					function(server_name)
						lspconfig[server_name].setup({ capabilities = require("blink.cmp").get_lsp_capabilities() })
					end,
					clangd = function()
						lspconfig.clangd.setup({
							capabilities = require("blink.cmp").get_lsp_capabilities(),
							cmd = { "clangd", "--offset-encoding=utf-16" },
						})
					end,
					pyright = function()
						lspconfig.pyright.setup({
							settings = {
								pyright = {
									disableOrganizeImports = true,
								},
								python = {
									pythonPath = vim.fn.getcwd() .. "/venv/bin/python",
									analysis = {
										typeCheckingMode = "off",
									},
								},
							},
						})
					end,
					lua_ls = function()
						lspconfig.lua_ls.setup({
							capabilities = require("blink.cmp").get_lsp_capabilities(),
							settings = {
								Lua = {
									workspace = {
										checkThirdParty = false,
									},
								},
							},
						})
					end,
					rust_analyzer = function()
						lspconfig.rust_analyzer.setup({
							capabilities = require("blink.cmp").get_lsp_capabilities(),
							on_attach = function(_, bufnr)
								vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
							end,
							settings = {
								rust_analyzer = {
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

				-- https://lsp-zero.netlify.app/v3.x/blog/you-might-not-need-lsp-zero
				vim.keymap.set("n", "gl", ":lua vim.diagnostic.open_float()<cr>")
				vim.keymap.set("n", "[d", ":lua vim.diagnostic.goto_prev()<cr>")
				vim.keymap.set("n", "]d", ":lua vim.diagnostic.goto_next()<cr>")

				vim.api.nvim_create_autocmd("LspAttach", {
					callback = function(args)
						local client = vim.lsp.get_client_by_id(args.data.client_id)
						if client then
							-- https://github.com/mrcjkb/rustaceanvim/discussions/135
							client.server_capabilities.semanticTokensProvider = nil
						end
						local opts = { noremap = true, silent = true, buffer = args.buf }
						vim.keymap.set("n", "<M-q>", vim.diagnostic.setqflist, opts)
						vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
						vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
						vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
						vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
						vim.keymap.set("n", "<Leader>k", vim.lsp.buf.signature_help, opts)
						vim.keymap.set("n", "<Leader>wa", vim.lsp.buf.add_workspace_folder, opts)
						vim.keymap.set("n", "<Leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
						vim.keymap.set("n", "<Leader>wl", function()
							print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
						end, opts)
						vim.keymap.set("n", "<Leader>D", vim.lsp.buf.type_definition, opts)
						vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, opts)
						vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, opts)
						vim.keymap.set("n", "<Leader>*", vim.lsp.buf.document_highlight, opts)
						vim.keymap.set("n", "<Leader><Leader>*", vim.lsp.buf.clear_references, opts)
						vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
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
					"clang-format",
					"clangd",
					"codelldb",
					"codespell",
					"cpptools",
					"css-lsp",
					"goimports",
					"gopls",
					"jsonlint",
					"lua-language-server",
					"marksman",
					"perlnavigator",
					"prettier",
					"pyright",
					"ruff",
					"rust-analyzer",
					"shfmt",
					"stylua",
					"taplo",
					"typescript-language-server",
					"vale",
					"yamllint",
				},
				-- use :MasonToolsUpdateSync
				run_on_start = false,
			},
			config = function(_, opts)
				local mason_tool_installer = require("mason-tool-installer")
				mason_tool_installer.setup(opts)
				vim.api.nvim_create_autocmd("User", {
					pattern = "MasonToolsUpdateCompleted",
					callback = function(_)
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
