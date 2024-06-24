return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			-- Customize or remove this keymap to your liking
			"<Leader>f",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	-- Everything in opts will be passed to setup()
	opts = {
		-- log_level = vim.log.levels.DEBUG,
		-- Define your formatters
		formatters_by_ft = {
			lua = { "stylua" },
			-- Conform will run multiple formatters sequentially
			go = { "goimports", "gofmt" },
			python = function(bufnr)
				if require("conform").get_formatter_info("ruff_format", bufnr).available then
					return { "ruff_format" }
				else
					return { "isort", "black" }
				end
			end,
			-- Use a sub-list to run only the first available formatter
			rust = { "rustfmt" },
			javascript = { "prettier" },
			typescript = { "prettier" },
			html = { "prettier" },
			yaml = { "prettier" },
			gohtmltmpl = { "prettier" },
			markdown = { "prettier" },
			css = { "prettier" },
			scss = { "prettier" },
			json = { "prettier" },
			-- Use the "*" filetype to run formatters on all filetypes.
			-- ["*"] = { "codespell" },
			-- Use the "_" filetype to run formatters on filetypes that don't
			-- have other formatters configured.
			-- ["_"] = { "trim_whitespace" },
		},
		-- Set up format-on-save
		-- format_on_save = { timeout_ms = 500, lsp_fallback = true },
		-- Customize formatters
		formatters = {},
	},
	init = function()
		-- If you want the formatexpr, here is the place to set it
		vim.o.formatexpr = ""
	end,
}
