return {
	"neomake/neomake",
	config = function()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "yaml", "markdown" },
			callback = function()
				vim.fn["neomake#configure#automake_for_buffer"]("nrwi", 500)
			end,
		})
	end,
}
