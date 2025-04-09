return {
	"rbmarliere/b4.nvim",
	cmd = { "B4" },
	-- name = "b4.nvim",
	-- dir = "~/src/rbmarliere/b4.nvim/main",
	-- dev = true,
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		log_level = "info",
		window = {
			new_tab = true,
			layout = {
				split = "below",
			},
		},
	},
	keys = {
		{
			"<Leader>bc",
			":B4 prep --auto-to-cc<CR>:B4 prep --check<CR>:B4 prep --check-deps<CR>:B4 trailers --update<CR>",
			desc = "b4 prep --auto-to-cc; b4 prep --check; b4 prep --check-deps; b4 trailers --update",
		},
		{ "<Leader>bpc", ":B4 prep --edit-cover<CR>", desc = "b4 prep --edit-cover" },
		{ "<Leader>bpd", ":B4 prep --edit-deps<CR>", desc = "b4 prep --edit-deps" },
		{ "<Leader>bpe", ":B4 prep --enroll<CR>", desc = "b4 prep --enroll" },
		{ "<Leader>bs", ":B4 send --reflect", desc = "b4 send --reflect" },
		{ "<Leader>bS", ":B4 shazam ", desc = "b4 shazam" },
	},
}
