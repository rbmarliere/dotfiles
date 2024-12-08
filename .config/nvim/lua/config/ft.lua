vim.filetype.add({
	extension = {
		gotmpl = "gotmpl",
	},
	pattern = {
		[".*/layouts/.*%.html"] = "gotmpl",
	},
})
