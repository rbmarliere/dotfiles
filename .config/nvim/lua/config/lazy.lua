local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local r = require("lazy").setup({
	change_detection = {
		enabled = true,
		notify = false,
	},
	spec = {
		{ import = "plugins" },
	},
})

vim.api.nvim_set_hl(0, "LazyButton", {
	link = "Search"
})

return r
