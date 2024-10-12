local qf = require("utils.quickfix")

return {
	"rmagatti/auto-session",
	opts = {
		auto_session_enabled = true,
		auto_save_enabled = true,
		auto_session_create_enabled = function()
			local cmd = "git rev-parse --is-inside-work-tree"
			return vim.fn.system(cmd) == "true\n"
		end,
		silent_restore = false,
		cwd_change_handling = {
			restore_upcoming_session = true,
		},
		save_extra_cmds = {
			-- https://github.com/rmagatti/auto-session/issues/173
			qf.get_qf
		},
	},
	init = function()
		vim.opt.sessionoptions:remove({ "blank", "terminal" }) -- exclude nvim-dap buffers
		-- https://github.com/rmagatti/auto-session/issues/204
		vim.opt.sessionoptions:append({ "localoptions" })
	end,
}
