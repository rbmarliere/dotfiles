return {
	"tpope/vim-fugitive",
	lazy = false,
	dependencies = {
		"tpope/vim-rhubarb",
		{
			"shumphrey/fugitive-gitlab.vim",
			init = function()
				-- vim.g.fugitive_gitlab_domains = { "" }
				-- vim.g.gitlab_api_keys = { [""] = "" }
			end,
		},
	},
	keys = {
		{ "<Leader>g", ":tab Git<CR>:tabm 0<CR>" },
		{ "<Leader>gb", ":Git blame<CR>:set number relativenumber<CR>" },
		{ "<Leader>gB", ":GBrowse<CR>" }, -- open URL at blob (can be file, tree, commit, ...)
		{ "<Leader>gL", ":GcLog %<CR>" }, -- add file history to quickfix
		{ "<Leader>gD", ":Gdiffsplit!<CR>" }, -- solve merge conflicts (use d2o and d3o)
		{ "<Leader>gW", ":Gwrite!<CR>" }, -- e.g. choose a version during conflict
		{ "<Leader>gE", ":e %:h<CR" }, -- parent tree of a blob http://vimcasts.org/episodes/fugitive-vim-browsing-the-git-object-database/
	},
}
