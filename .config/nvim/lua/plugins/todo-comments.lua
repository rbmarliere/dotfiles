return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {},
	init = function()
		require("telescope").load_extension("todo-comments")
	end
}
