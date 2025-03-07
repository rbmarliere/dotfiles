local lspconfig = require("lspconfig")
lspconfig.perlnavigator.setup({
	settings = {
		perlnavigator = {
			includePaths = { "~/src/os-autoinst/os-autoinst/master" },
			enableWarnings = true,
			perltidyProfile = "~/src/os-autoinst/os-autoinst/master/.perltidyrc",
			perlcriticProfile = "",
			perlcriticEnabled = true,
		},
	},
})

local conform = require("conform")
require("conform").formatters.yamltidy = {
	command = "yamltidy",
	args = "-c ~/src/os-autoinst/os-autoinst/master/.yamltidy $FILENAME",
	-- range_args = function(self, ctx)
	-- 	return { "--partial" }
	-- end,
	stdin = true,
}
--
vim.api.nvim_create_autocmd("FileType", {
	pattern = "gitcommit",
	callback = function()
		vim.opt_local.colorcolumn = "72"
	end,
})
