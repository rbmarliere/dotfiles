return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"folke/neodev.nvim",
		"hrsh7th/nvim-cmp",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		require("lspconfig.ui.windows").default_options.border = "none"
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { noremap = true, silent = true, buffer = ev.buf }
				vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
				vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
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
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
			end,
		})
		vim.diagnostic.config({
			virtual_text = false,
		})
	end,
}
