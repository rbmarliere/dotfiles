return {
	"tpope/vim-fugitive",
	lazy = false,
	keys = {
		{ "<Leader>g", ":vert Git<CR>" },
		{ "<Leader>G", ":tab Git<CR>:tabm 0<CR>" },
		{ "<Leader><Leader>g", ":Git blame<CR>:set number relativenumber<CR>" },
	},
}
