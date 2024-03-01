local get_maintainer = require("utils.get_maintainer")

local opts = { noremap = true }

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", opts)

vim.keymap.set("n", "<Leader>M", get_maintainer.get_from_file, opts)
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "fugitive" },
	callback = function()
		local opts = { noremap = true, buffer = true }
		vim.keymap.set("n", "<Leader>M", get_maintainer.get_from_cursor, opts)
		vim.keymap.set("x", "<Leader>M", get_maintainer.get_from_range, opts)
	end,
})
