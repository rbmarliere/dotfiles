local colors = require("utils.colors")
ColorColumn = nil

return {
	"folke/zen-mode.nvim",
	opts = {
		window = {
			width = 100,
		},
		plugins = {
			tmux = { enabled = true },
			options = {
				enabled = true,
				showcmd = true,
				laststatus = 3,
			},
		},
		on_open = function(_)
			ColorColumn = vim.opt_local.colorcolumn
			vim.opt_local.colorcolumn = ""
			vim.api.nvim_set_hl(0, "Normal", { bg = colors.lighterwhite })
			require("lualine").setup({ options = { globalstatus = true } })
		end,
		on_close = function(_)
			vim.opt_local.colorcolumn = ColorColumn
			vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
			require("lualine").setup({ options = { globalstatus = false } })
		end,
	},
	keys = {
		{ "<leader>z", ":ZenMode<CR>" },
	},
}
