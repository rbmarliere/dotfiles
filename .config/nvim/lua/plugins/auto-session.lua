local qf = require("utils.quickfix")

local pre_save = function()
	local auto_session = require("auto-session.lib")
	local session = auto_session.current_session_name(false)
	local opts = {}
	opts.args = vim.fn.stdpath("data") .. "/qf/" .. auto_session.escape_session_name(session)
	require("auto-session")
	qf.save_qf(opts)
end

local post_restore = function()
	local auto_session = require("auto-session.lib")
	local session = auto_session.current_session_name(false)
	local qf_file = vim.fn.stdpath("data") .. "/qf/" .. auto_session.escape_session_name(session)
	if vim.fn.filereadable(qf_file) ~= 1 then
		return
	end
	vim.cmd("source " .. auto_session.escape_string_for_vim(qf_file))
	qf.toggle_qf()
end

return {
	"rmagatti/auto-session",
	opts = {
		-- log_level = "debug",
		-- auto_session_enable_last_session = false,
		-- auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
		auto_session_enabled = true,
		auto_save_enabled = true,
		auto_session_create_enabled = function()
			local cmd = "git rev-parse --is-inside-work-tree"
			return vim.fn.system(cmd) == "true\n"
		end,
		silent_restore = false,
		-- auto_restore_enabled = nil,
		-- auto_session_suppress_dirs = nil,
		-- auto_session_use_git_branch = false,
		-- the configs below are lua only
		-- bypass_session_save_file_types = nil, -- table: Bypass auto save when only buffer open is one of these file types
		-- close_unsupported_windows = true, -- boolean: Close windows that aren't backed by normal file
		cwd_change_handling = { -- table: Config for handling the DirChangePre and DirChanged autocmds, can be set to nil to disable altogether
			restore_upcoming_session = true, -- boolean: restore session for upcoming cwd on cwd change
			-- pre_cwd_changed_hook = nil, -- function: This is called after auto_session code runs for the `DirChangedPre` autocmd
			-- post_cwd_changed_hook = nil, -- function: This is called after auto_session code runs for the `DirChanged` autocmd
		},
		-- args_allow_single_directory = true, -- boolean Follow normal sesion save/load logic if launched with a single directory as the only argument
		-- args_allow_files_auto_save = false, -- boolean|function Allow saving a session even when launched with a file argument (or multiple files/dirs). It does not load any existing session first. While you can just set this to true, you probably want to set it to a function that decides when to save a session when launched with file args. See documentation for more detail
		pre_save_cmds = {
			pre_save,
		},
		post_restore_cmds = {
			post_restore,
		},
	},
	init = function()
		vim.opt.sessionoptions:remove({ "blank", "terminal" }) -- exclude nvim-dap buffers
		-- https://github.com/rmagatti/auto-session/issues/204
		vim.opt.sessionoptions:append({ "localoptions" })
	end,
}
