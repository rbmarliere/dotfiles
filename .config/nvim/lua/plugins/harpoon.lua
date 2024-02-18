local harpoon

return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = {
		-- "nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim",
	},
	config = function()
		harpoon = require("harpoon"):setup()
	end,
	keys = {
		{
			"<Leader>a",
			function()
				harpoon:list():append()
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
