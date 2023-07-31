vim.api.nvim_create_autocmd({
	"BufWinEnter",
}, {
	buffer = 0,
	command = vim.cmd.wincmd("H"),
})

vim.cmd.setlocal("spell")

local cmp = require("cmp")
cmp.setup.buffer({
	sources = cmp.config.sources({ { name = "conventionalcommits" } }, { { name = "buffer" } }),
})
