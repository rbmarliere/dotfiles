return {
	"j-hui/fidget.nvim",
	lazy = false,
	opts = {
		notification = {
			window = {
				normal_hl = "NormalFloat",
				winblend = 0,
			},
		},
	},
	keys = {
		{ "<Leader><Leader>", "<Cmd>nohlsearch<CR><Cmd>Fidget clear<CR><Cmd>lua vim.lsp.buf.clear_references()<CR>" }
	},
}
