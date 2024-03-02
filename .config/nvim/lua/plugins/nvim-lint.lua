return {
	"mfussenegger/nvim-lint",
	config = function()
		local lint = require("lint")
		lint.linters.klint = {
			name = "klint",
			cmd = "rustup",
			args = {
				"run",
				"1.75.0",
				"klint",
				"--error-format",
				"short",
			},
			stdin = false,
			ignore_exitcode = true,
			stream = "stderr",
			parser = require("lint.parser").from_errorformat("%f:%l:%c: %m"),
		}
		lint.linters.codespell.args = {
			"--config",
			"~/.codespellrc",
			"--config",
			"../.codespellrc",
			"--config",
			".codespellrc",
		}
		lint.linters_by_ft = {
			c = { "checkpatch" },
			markdown = { "vale" },
			-- rust = { "klint" },
		}
		vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave", "TextChanged" }, {
			callback = function()
				lint.try_lint()
				-- lint.try_lint("codespell", { ignore_errors = true })
			end,
		})
	end,
}
