return {
	"norcalli/nvim-colorizer.lua",
	config = function()
		require("colorizer").setup({
			"lua",
			"scss",
			"css",
			"html",
		})
	end,
}
