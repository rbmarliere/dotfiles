return {
	"j-hui/fidget.nvim",
	opts = {
		notification = {
			window = {
				normal_hl = "NormalFloat",
				winblend = 0,
			},
		},
	},
	keys = {
		{ "<Leader><Leader>", ":nohlsearch<CR>:Fidget clear<CR>:lua vim.lsp.buf.clear_references()<CR>" }
	},
}
