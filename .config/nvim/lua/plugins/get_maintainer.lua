return {
	"rbmarliere/get_maintainer.nvim",
	opts = {
		use_clipboard = "unnamed",
	},
	config = function(_, opts)
		local get_maintainer = require("get_maintainer")
		get_maintainer.setup(opts)
		vim.keymap.set("n", "<Leader>M", get_maintainer.get_from_file, { noremap = true })
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "fugitive" },
			callback = function()
				vim.keymap.set("n", "<Leader>M", get_maintainer.get_from_cursor, { noremap = true, buffer = true })
				vim.keymap.set("x", "<Leader>M", get_maintainer.get_from_range, { noremap = true, buffer = true })
			end,
		})
	end,
}
