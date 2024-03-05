return {
	"dhananjaylatkar/cscope_maps.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("cscope_maps").setup({
			disable_maps = true,
			cscope = {
				picker = "telescope",
			},
		})
	end,
}
