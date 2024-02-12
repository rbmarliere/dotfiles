return {
	"github/copilot.vim",
	init = function()
		-- vim.g.copilot_enabled = false
		vim.g.copilot_filetypes = {
			["dap-repl"] = false,
			["text"] = false,
			["mail"] = false,
		}
	end,
}
