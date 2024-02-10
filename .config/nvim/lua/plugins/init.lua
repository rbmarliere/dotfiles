return {
	"christoomey/vim-tmux-navigator",
	"jamessan/vim-gnupg",
	"tpope/vim-commentary",
	"tpope/vim-repeat",
	"tpope/vim-surround",
	"tpope/vim-unimpaired",
	{ "glts/vim-radical", dependencies = { "glts/vim-magnum" } },
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
}
