return {
	-- 	"polarmutex/git-worktree.nvim",
	name = "git-worktree.nvim",
	dir = "~/src/rbmarliere/git-worktree.nvim/main",
	dev = true,
	init = function()
		-- vim.g.git_worktree_log_level = "debug"
		vim.g.git_worktree = {
			change_directory_command = "cd",
			update_on_change = false,
			update_on_change_command = "e .",
			clearjumps_on_change = true,
			confirm_telescope_deletions = true,
			autopush = false,
		}

		require("telescope").load_extension("git_worktree")

		local Hooks = require("git-worktree.hooks")
		Hooks.register(Hooks.type.CREATE, function(path, branch, upstream)
			require("plenary.job"):new({
				command = "git",
				args= { "submodule", "update", "--recursive", "--init" },
				cwd = path
			}):start()
		end)

		-- if cwd is a bare repo and there's zero arguments to the cmd,
		-- open telescope extension upon entering nvim
		vim.api.nvim_create_autocmd("VimEnter", {
			callback = function()
				if vim.fn.argc() > 0 then
					return
				end
				local cmd = "git rev-parse --is-bare-repository"
				if vim.fn.system(cmd) == "true\n" then
					require("telescope").extensions.git_worktree.git_worktree()
				end
			end,
		})
	end,
}
