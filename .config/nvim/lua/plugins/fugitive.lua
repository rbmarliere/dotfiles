return {
	"tpope/vim-fugitive",
	lazy = false,
	keys = {
		{ "<Leader>g", ":Git<CR>" },
		{ "<Leader>gc", ":Git commit -v<CR>" },
		{ "<Leader>sa", ":Git stash apply<CR>" },
		{ "<Leader>sx", ":Git stash<CR>" },
		{ "<Leader>pl", ":Git pull --rebase " },
		{ "<Leader>px", ":Git push<CR>" },
	},
}
