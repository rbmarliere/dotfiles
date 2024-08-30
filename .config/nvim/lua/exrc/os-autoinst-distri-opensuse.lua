local lspconfig = require("lspconfig")
lspconfig.perlnavigator.setup({
	settings = {
		perlnavigator = {
			includePaths = { "~/src/os-autoinst/os-autoinst/main" },
			enableWarnings = true,
			perltidyProfile = "~/src/os-autoinst/os-autoinst/main/.perltidyrc",
			perlcriticProfile = "",
			perlcriticEnabled = true,
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

-- local Hooks = require("git-worktree.hooks")
-- Hooks.register(Hooks.type.CREATE, function(path, branch, upstream)
-- 	require("plenary.job")
-- 		:new({
-- 			command = "ln",
-- 			args = { "-s", "", "--recursive", "--init" },
-- 			cwd = path,
-- 		})
-- 		:start()
-- end)
