local grepprg = "rg --pcre2 --vimgrep --no-heading --smart-case --hidden --glob !.git --line-number --column"
local grepprg_tbl = {}
for word in grepprg:gmatch("%S+") do
	table.insert(grepprg_tbl, word)
end

vim.opt.grepprg = grepprg

return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",
	dependencies = {
		"keyvchan/telescope-find-pickers.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-file-browser.nvim",
		"nvim-telescope/telescope-live-grep-args.nvim",
		"rbmarliere/telescope-cscope.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	keys = {
		{ "<C-Space>", ":Telescope find_pickers<CR>" },
		{ "<M-p>", ":Telescope find_files<CR>" },
		{ "<C-p>", ":Telescope git_files<CR>" },
		{ "-", ":Telescope file_browser path=%:p:h<CR>" },
		{ "<M-g>", ":Telescope live_grep_args<CR>" },
	},
	config = function()
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")
		local action_state = require("telescope.actions.state")
		local actions = require("telescope.actions")
		local fb_utils = require("telescope._extensions.file_browser.utils")
		local fb_actions = require("telescope._extensions.file_browser.actions")
		local Path = require("plenary.path")

		local picker_config = {}
		for b, _ in pairs(builtin) do
			picker_config[b] = {
				fname_width = 60,
				symbol_width = 50,
				symbol_type_width = 15,
			}
		end

		-- https://github.com/nvim-telescope/telescope-file-browser.nvim/wiki/Configuration-Recipes
		local path_toggle = function(prompt_bufnr)
			local current_picker = action_state.get_current_picker(prompt_bufnr)
			local finder = current_picker.finder
			local bufr_path = Path:new(vim.fn.expand("#:p"))
			local bufr_parent_path = bufr_path:parent():absolute()
			if finder.path ~= bufr_parent_path then
				finder.path = bufr_parent_path
				fb_utils.selection_callback(current_picker, bufr_path:absolute())
			else
				finder.path = vim.loop.cwd()
			end
			fb_utils.redraw_border_title(current_picker)
			current_picker:refresh(finder, {
				new_prefix = fb_utils.relative_path_prefix(finder),
				reset_prompt = true,
				multi = current_picker._multi,
			})
		end
		local grep_in_dir = function(prompt_bufnr)
			local selections = fb_utils.get_selected_files(prompt_bufnr, false)
			local search_dirs = vim.tbl_map(function(path)
				return path:absolute()
			end, selections)
			if vim.tbl_isempty(search_dirs) then
				local current_finder = action_state.get_current_picker(prompt_bufnr).finder
				search_dirs = { current_finder.path }
			end
			actions.close(prompt_bufnr)
			require("telescope").extensions.live_grep_args.live_grep_args({
				search_dirs = search_dirs,
			})
		end

		local opts = {
			defaults = {
				border = true,
				borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
				sorting_strategy = "ascending",
			},
			pickers = vim.tbl_extend("force", picker_config, {
				find_files = {
					find_command = { "rg", "--files", "--hidden", "--glob", "!.git", "--no-ignore-vcs" },
				},
				man_pages = {
					sections = { "1", "2", "3", "4", "5", "6", "7", "8", "9" },
				},
				live_grep = {
					vimgrep_arguments = grepprg_tbl,
				},
			}),
			extensions = {
				live_grep_args = {
					vimgrep_arguments = grepprg_tbl,
					mappings = {
						i = {
							["<C-k>"] = function(prompt_bufnr)
								require("telescope-live-grep-args.actions").quote_prompt()(prompt_bufnr)
							end,
							["<C-j>"] = function(prompt_bufnr)
								require("telescope-live-grep-args.actions").quote_prompt({ postfix = " --iglob " })(
									prompt_bufnr
								)
							end,
						},
					},
				},
				file_browser = {
					git_status = false,
					hidden = { file_browser = true, folder_browser = true },
					hide_parent_dir = true,
					hijack_netrw = true,
					mappings = {
						i = {
							["<C-t>"] = actions.select_tab, -- https://github.com/nvim-telescope/telescope-file-browser.nvim/issues/250
							["<M-g>"] = grep_in_dir,
							["<C-e>"] = path_toggle,
						},
						n = {
							["-"] = fb_actions.goto_parent_dir,
							t = actions.select_tab,
							T = fb_actions.change_cwd,
							["<M-g>"] = grep_in_dir,
							["<C-e>"] = path_toggle,
						},
					},
				},
			},
		}

		telescope.setup(opts)
		telescope.load_extension("cscope")
		telescope.load_extension("file_browser")
		telescope.load_extension("find_pickers")
		telescope.load_extension("fzf")
		telescope.load_extension("live_grep_args")
	end,
}
