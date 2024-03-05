ColorColumn = nil

return {
	"folke/zen-mode.nvim",
	opts = {
		window = {
			width = 100,
		},
		plugins = {
			tmux = { enabled = true },
			-- options = { laststatus = 3 },
		},
		on_open = function(_)
			ColorColumn = vim.opt_local.colorcolumn
			vim.opt_local.colorcolumn = ""
			vim.api.nvim_win_set_option(0, "winhighlight", "Normal:Opaque")
		end,
		on_close = function(_)
			vim.opt_local.colorcolumn = ColorColumn
		end,
	},
	keys = {
		{ "<leader>z", ":ZenMode<CR>" },
	},
}
