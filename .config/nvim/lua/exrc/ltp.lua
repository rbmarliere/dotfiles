local checkpatch = require("lint").linters.checkpatch
checkpatch.cmd = "scripts/checkpatch.pl"
checkpatch.args = {
	"--strict",
	"--terse",
	"--file",
	"--no-tree",
	"--no-summary",
	"--ignore",
	"CONST_STRUCT,VOLATILE,SPLIT_STRING",
}

vim.api.nvim_create_autocmd("User", {
	pattern = "FugitiveIndex",
	callback = function()
		vim.keymap.set("n", "cc", ":Git commit -s<CR>", { buffer = true })
	end,
})
