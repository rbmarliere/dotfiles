return {
	"tpope/vim-fugitive",
	lazy = false,
	keys = {
		{ "<Leader>g", ":Git<CR>" },
	},
	init = function()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "fugitive",
			group = vim.api.nvim_create_augroup("UserFugitiveConfig", {}),
			callback = function(ev)
				local opts = { noremap = true, silent = true, buffer = ev.buf }
				vim.keymap.set("n", "cc", ":Git ci<CR>", opts)
			end
		})
	end
}
