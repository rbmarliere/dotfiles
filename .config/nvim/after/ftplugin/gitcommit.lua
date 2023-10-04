vim.opt_local.spell = true
vim.opt_local.tw = 75
vim.opt_local.wrap = true

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	buffer = 0,
	command = vim.cmd.wincmd("H"),
})

local cmp = require("cmp")
cmp.setup.buffer({
	sources = cmp.config.sources({ { name = "conventionalcommits" } }, { { name = "buffer" } }),
})
