return {
	"github/copilot.vim",
	enabled = false,
	init = function()
		vim.g.copilot_filetypes = {
			["dap-repl"] = false,
			["text"] = false,
			["mail"] = false,
		}
	end,
}
