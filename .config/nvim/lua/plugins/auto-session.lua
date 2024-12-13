local qf = require("utils.quickfix")

return {
	"rmagatti/auto-session",
	-- name = "auto-session",
	-- dir = "~/src/extra/auto-session/main",
	-- dev = true,
	opts = {
		-- log_level = vim.log.levels.DEBUG,
		auto_session_enabled = true,
		auto_save_enabled = true,
		auto_session_create_enabled = function()
			local cmd = "git rev-parse --is-inside-work-tree"
			return vim.fn.system(cmd) == "true\n"
		end,
		silent_restore = false,
		cwd_change_handling = true,
		save_extra_cmds = {
			-- https://github.com/rmagatti/auto-session/issues/173
			qf.get_qf,
		},
		pre_save_cmds = {
			function()
				-- close buffers by filetype like gitcommit
				for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
					local bufft = vim.api.nvim_buf_get_option(bufnr, "filetype")
					if string.match(bufft, "git*") then
						vim.api.nvim_buf_delete(bufnr, { force = true })
					end
				end
			end,
		},
		post_save_cmds = {
			function()
				local buffers = vim.tbl_filter(function(buf)
					return vim.api.nvim_buf_is_loaded(buf)
				end, vim.api.nvim_list_bufs())
				if #buffers > 1 then
					-- empty and close quickfix list so it doesn't flow into empty sessions
					vim.cmd("bufdo bd")
					-- close all buffers so past sessions don't flow into empty sessions
					vim.cmd("cexpr []")
					vim.cmd("cclose")
				end
			end,
		},
		post_restore_cmds = {
			function()
				-- re-enable git signs in all buffers
				for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
					vim.api.nvim_buf_call(bufnr, function()
						vim.cmd("Gitsigns attach")
						require("lualine").refresh()
					end)
				end
			end,
		},
	},
	init = function()
		vim.opt.sessionoptions:remove({ "blank", "terminal" }) -- exclude nvim-dap buffers
		-- https://github.com/rmagatti/auto-session/issues/204
		vim.opt.sessionoptions:append({ "localoptions" })
	end,
}
