vim.api.nvim_create_autocmd("User", {
	pattern = "FugitiveIndex",
	callback = function()
		vim.keymap.set("n", "cc", ":Git commit -s<CR>", { buffer = true })
	end,
})
