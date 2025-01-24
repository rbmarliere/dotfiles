return {
	{ "tpope/vim-commentary" },
	{ "tpope/vim-endwise" },
	{ "tpope/vim-unimpaired" },
	{ "tpope/vim-surround" },
	{ "tpope/vim-sleuth" },
	{ "tpope/vim-repeat" },
	{
		"tpope/vim-fugitive",
		lazy = false,
		dependencies = {
			"tpope/vim-rhubarb",
			{
				"shumphrey/fugitive-gitlab.vim",
				init = function()
					vim.g.fugitive_gitlab_domains = { "gitlab.suse.de" }
				end,
			},
			{
				"sudotac/fugitive-cgit.vim",
				init = function()
					vim.g.fugitive_cgit_domains = { "https://git.kernel.org" }
				end,
			},
		},
		keys = {
			{ "<Leader>gg", ":tab Git<CR>:tabm 0<CR>" },
			{ "<Leader>gb", ":Git blame<CR>:set number relativenumber<CR>" },
			{ "<Leader>gB", ":GBrowse<CR>", mode = { "n", "v" }, desc = "Open URL at object" },
			{ "<Leader>gl", ":Git log --oneline<CR>" },
			{ "<Leader>gL", ":GcLog %<CR>", desc = "Add file history to quickfix" },
			{ "<Leader>gD", ":Gdiffsplit!<CR>", desc = "Solve merge conflicts (use d2o and d3o)" },
			{ "<Leader>gW", ":Gwrite!<CR>", desc = "Choose a version e.g. during conflict" },
			{ "<Leader>ge", ":Gedit<CR>", desc = "Go to current version of object" },
			{ "<Leader>gE", ":e %:h<CR>", desc = "Browse parent tree of object" }, -- http://vimcasts.org/episodes/fugitive-vim-browsing-the-git-object-database/
			{ "<Leader>gp", ":G pull origin<CR>" },
			{ "<Leader>gP", ":G push " },
			{ "<Leader>gsR", ":G set-pushRemote rbmarliere" },
			{ "<Leader>gsO", ":G set-origin origin" },
			{ "<Leader>gsU", ":G branch -u main" },
			{ "<Leader>gse", ":G send-email --cover-letter" },
		},
	},
}
