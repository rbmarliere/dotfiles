local zen = require("zen-mode")
zen.setup({
	window = {
		width = 95,
		options = {
			number = true,
			relativenumber = true,
		},
	},
})
vim.keymap.set("n", "<Leader>z", zen.toggle)
