local harpoon

return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	-- https://github.com/ThePrimeagen/harpoon/issues/577 https://github.com/ThePrimeagen/harpoon/pull/557
	commit = "e76cb03c420bb74a5900a5b3e1dde776156af45f",
	dependencies = {
		-- "nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim",
	},
	lazy = false,
	config = function()
		harpoon = require("harpoon"):setup()
	end,
	keys = {
		{
			"<Leader>A",
			function()
				harpoon:list():add()
			end,
		},
		{
			"<Leader>L",
			function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end,
		},
		{
			"<Leader>h",
			function()
				harpoon:list():select(1)
			end,
		},
		{
			"<Leader>t",
			function()
				harpoon:list():select(2)
			end,
		},
		{
			"<Leader>n",
			function()
				harpoon:list():select(3)
			end,
		},
		{
			"<Leader>s",
			function()
				harpoon:list():select(4)
			end,
		},
		{
			"<Leader>\\",
			function()
				harpoon:list():select(5)
			end,
		},
	},
}
