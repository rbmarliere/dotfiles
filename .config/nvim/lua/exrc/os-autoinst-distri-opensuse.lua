local lspconfig = require("lspconfig")
lspconfig.perlnavigator.setup({
	settings = {
		perlnavigator = {
			includePaths = { "~/src/os-autoinst/os-autoinst/main" },
		},
	},
})

local conform = require("conform")
require("conform").formatters.yamltidy = {
	command = "yamltidy",
	args = "-c ~/src/os-autoinst/os-autoinst/main/.yamltidy $FILENAME",
	-- range_args = function(self, ctx)
	-- 	return { "--partial" }
	-- end,
	stdin = true,
}
