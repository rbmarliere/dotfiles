return {
	"mfussenegger/nvim-lint",
	config = function()
		local lint = require("lint")
		lint.linters.codespell = {
			cmd = "codespell --config ~/.codespellrc --config ../.codespellrc",
			stdin = false,
			ignore_exitcode = true,
			parser = require("lint.parser").from_errorformat(
				"%f:%l:%m",
				{ severity = vim.diagnostic.severity.INFO, source = "codespell" }
			),
		}
		lint.linters_by_ft = {
			c = { "checkpatch" },
			markdown = { "vale" },
		}
		vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave", "TextChanged" }, {
			callback = function()
				lint.try_lint()
				lint.try_lint("codespell", { ignore_errors = true })
			end,
		})
	end,
}
