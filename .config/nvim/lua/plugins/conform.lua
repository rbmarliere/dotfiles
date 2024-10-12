return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<Leader>f",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	opts = {
		-- log_level = vim.log.levels.DEBUG,
		default_format_opts = {
			lsp_format = "fallback",
		},
		formatters_by_ft = {
			css = { "prettier" },
			go = { "goimports", "gofmt" },
			gohtmltmpl = { "prettier" },
			html = { "prettier" },
			javascript = { "prettier" },
			json = { "prettier" },
			lua = { "stylua" },
			markdown = { "prettier" },
			python = { "black" },
			rust = { "rustfmt" },
			scss = { "prettier" },
			typescript = { "prettier" },
			yaml = { "yamltidy" },
			-- ["*"] = { "codespell" }, -- apply to all filetypes
			-- ["_"] = { "trim_whitespace" },
		},
	},
	init = function()
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
