return {
	"mfussenegger/nvim-lint",
	lazy = false,
	init = function()
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
			yaml = { "yamllint" },
		}
		vim.api.nvim_create_autocmd(
			{ "BufWinEnter", "BufEnter", "BufWritePost", "BufReadPost", "InsertLeave", "TextChanged" },
			{
				callback = function()
					lint.try_lint()
				end,
			}
		)
		-- Show linters for the current buffer's file type
		-- https://github.com/mfussenegger/nvim-lint/issues/559
		vim.api.nvim_create_user_command("LintInfo", function()
			local filetype = vim.bo.filetype
			local linters = require("lint").linters_by_ft[filetype]

			if linters then
				print("Linters for " .. filetype .. ": " .. table.concat(linters, ", "))
			else
				print("No linters configured for filetype: " .. filetype)
			end
		end, {})
	end,
}
