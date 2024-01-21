return {
	"rmagatti/auto-session",
	config = function()
		vim.opt.sessionoptions:remove({ "blank", "terminal" }) -- exclude nvim-dap buffers
		require("auto-session").setup()
	end,
}
