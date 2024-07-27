return {
	"tpope/vim-fugitive",
	lazy = false,
	keys = {
		{ "<Leader>g", ":tab Git<CR>:tabm 0<CR>" },
		{ "<Leader>gB", ":Git blame<CR>:set number relativenumber<CR>" },
	},
}
