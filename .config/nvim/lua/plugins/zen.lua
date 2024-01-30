ColorColumn = nil

return {
	"folke/zen-mode.nvim",
	opts = {
		window = {
			width = 100,
		},
		plugins = {
			tmux = { enabled = true },
		},
		on_open = function(_)
			ColorColumn = vim.opt_local.colorcolumn
			vim.opt_local.colorcolumn = ""
		end,
		on_close = function(_)
			vim.opt_local.colorcolumn = ColorColumn
		end,
	},
	keys = {
		{ "<leader>z", ":ZenMode<CR>" },
	},
}
