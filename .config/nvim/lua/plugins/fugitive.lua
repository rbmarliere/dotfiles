return {
	"tpope/vim-fugitive",
	lazy = false,
	dependencies = {
		"tpope/vim-rhubarb",
		{
			"shumphrey/fugitive-gitlab.vim",
			init = function()
				vim.g.fugitive_gitlab_domains = { "gitlab.suse.de" }
				-- vim.g.gitlab_api_keys = { [""] = "" }
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
		{ "<Leader>g", ":tab Git<CR>:tabm 0<CR>" },
		{ "<Leader>gb", ":Git blame<CR>:set number relativenumber<CR>" },
		{ "<Leader>gB", ":GBrowse<CR>", mode = { "n", "v" } }, -- open URL at blob (can be file, tree, commit, ...)
		{ "<Leader>gl", ":Git log --oneline<CR>" },
		{ "<Leader>gL", ":GcLog %<CR>" }, -- add file history to quickfix
		{ "<Leader>gD", ":Gdiffsplit!<CR>" }, -- solve merge conflicts (use d2o and d3o)
		{ "<Leader>gW", ":Gwrite!<CR>" }, -- e.g. choose a version during conflict
		{ "<Leader>ge", ":Gedit<CR>" }, -- go to current version, from a fugitive-object
		{ "<Leader>gE", ":e %:h<CR>" }, -- parent tree of a blob http://vimcasts.org/episodes/fugitive-vim-browsing-the-git-object-database/
		{ "<Leader>gp", ":G pull origin<CR>" },
		{ "<Leader>gP", ":G push " },
		{ "<Leader>gsR", ":G set-pushRemote rbmarliere" },
		{ "<Leader>gsO", ":G set-origin origin" },
		{ "<Leader>gsU", ":G branch -u main" },
	},
}
