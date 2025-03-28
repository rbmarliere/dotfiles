return {
	"j-hui/fidget.nvim",
	-- lazy = false,
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
