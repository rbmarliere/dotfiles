return {
	"stevearc/oil.nvim",
	lazy = false,
	opts = {
		default_file_explorer = true,
		-- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
		-- options with a `callback` (e.g. { callback = function() ... end, desc = "", mode = "n" })
		-- Additionally, if it is a string that matches "actions.<name>",
		-- it will use the mapping at require("oil.actions").<name>
		-- Set to `false` to remove a keymap
		-- See :help oil-actions for a list of all available actions
		keymaps = {
			--   ["g?"] = { "actions.show_help", mode = "n" },
			--   ["<CR>"] = "actions.select",
			--   ["<C-s>"] = { "actions.select", opts = { vertical = true } },
			--   ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
			["<C-h>"] = false,
			--   ["<C-t>"] = { "actions.select", opts = { tab = true } },
			["<M-P>"] = { "actions.preview", opts = { horizontal = true, split = "belowright" } },
			["<C-p>"] = false, -- {
			-- callback = function()
			-- 	local count = vim.v.count1
			-- 	vim.cmd("normal! " .. count .. "k")
			-- end,
			-- },
			--   ["<C-c>"] = { "actions.close", mode = "n" },
			--   ["<C-l>"] = "actions.refresh",
			["<C-l>"] = false,
			--   ["-"] = { "actions.parent", mode = "n" },
			--   ["_"] = { "actions.open_cwd", mode = "n" },
			["_"] = false,
			--   ["`"] = { "actions.cd", mode = "n" },
			--   ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
			--   ["gs"] = { "actions.change_sort", mode = "n" },
			--   ["gx"] = "actions.open_external",
			--   ["g."] = { "actions.toggle_hidden", mode = "n" },
			--   ["g\\"] = { "actions.toggle_trash", mode = "n" },
		},
	},
	keys = {
		{ "-", "<Cmd>Oil<CR>" },
	},
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function(_, opts)
		local oil = require("oil")

		local grep_in_dir = function()
			local search_dirs = oil.get_current_dir()
			require("telescope").extensions.live_grep_args.live_grep_args({
				search_dirs = { search_dirs },
			})
		end
		opts.keymaps["<M-g>"] = { grep_in_dir }

		-- https://github.com/stevearc/oil.nvim/blob/master/doc/recipes.md#toggle-file-detail-view
		opts.keymaps["gd"] = {
			desc = "Toggle file detail view",
			callback = function()
				detail = not detail
				if detail then
					oil.set_columns({ "icon", "permissions", "size", "mtime" })
				else
					oil.set_columns({ "icon" })
				end
			end,
		}

		oil.setup(opts)
	end,
}
