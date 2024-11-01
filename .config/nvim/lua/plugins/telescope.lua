local grepprg = "rg --pcre2 --vimgrep --no-heading --smart-case --hidden --glob !.git --line-number --column --follow"
local grepprg_tbl = {}
for word in grepprg:gmatch("%S+") do
	table.insert(grepprg_tbl, word)
end

vim.opt.grepprg = grepprg

return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	-- name = "telescope.nvim",
	-- dir = "~/src/extra/telescope.nvim/master",
	-- dev = true,
	dependencies = {
		"keyvchan/telescope-find-pickers.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-file-browser.nvim",
		"nvim-telescope/telescope-live-grep-args.nvim",
		"rbmarliere/telescope-cscope.nvim",
		"tsakirist/telescope-lazy.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	keys = {
		{ "<C-Space>", ":Telescope find_pickers<CR>" },
		{ "<C-(>", ":Telescope lsp_document_symbols<CR>" },
		{ "<M-p>", ":Telescope find_files<CR>" },
		{ "<C-p>", ":Telescope git_files<CR>" },
		{ "-", ":Telescope file_browser path=%:p:h<CR>" },
		{ "<M-g>", ":Telescope live_grep_args<CR>" },
		{ "<Leader>gw", ":Telescope git_worktree<CR>" },
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
				-- https://github.com/nvim-telescope/telescope.nvim/issues/2779
				temp__scrolling_limit = 1000,
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
				layout_strategy = "flex",
				layout_config = {
					flex = {
						flip_columns = 140,
					},
					vertical = {
						height = 0.98,
						mirror = true,
						prompt_position = "top",
						preview_height = 30,
					},
				},
				border = true,
				borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
				sorting_strategy = "ascending",
				vimgrep_arguments = grepprg_tbl,
			},
			pickers = vim.tbl_extend("force", picker_config, {
				find_files = {
					find_command = { "rg", "--files", "--hidden", "--glob", "!.git", "--no-ignore-vcs" },
				},
				man_pages = {
					sections = { "1", "2", "3", "4", "5", "6", "7", "8", "9" },
				},
				-- https://github.com/nvim-telescope/telescope.nvim/issues/2933
				git_branches = {
					-- show_tags = true,
					mappings = {
						i = {
							["<C-d>"] = "preview_scrolling_down",
						},
					},
					previewer = require("telescope.previewers").new_termopen_previewer({
						get_command = function(entry)
							return {
								"git",
								"--no-pager",
								"log",
								"--max-count",
								"150",
								"--pretty=format:%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset",
								"--abbrev-commit",
								"--date=relative",
								entry.value,
							}
						end,
						scroll_fn = function(self, direction)
							if not self.state then
								return
							end
							local input =
								vim.api.nvim_replace_termcodes(direction > 0 and "<C-e>" or "<C-y>", true, false, true)
							local count = math.abs(direction)
							vim.api.nvim_buf_call(self.state.termopen_bufnr, function()
								vim.cmd([[normal! ]] .. count .. input)
							end)
						end,
					}),
				},
			}),
			extensions = {
				live_grep_args = {
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
					-- https://github.com/nvim-telescope/telescope.nvim/issues/2779
					temp__scrolling_limit = 1000,
					-- layout_strategy = "flex",
					-- layout_config = {
					-- 	vertical = {
					-- 		preview_height = 0,
					-- 	},
					-- },
					grouped = true,
					prompt_path = true,
					git_status = false,
					respect_gitignore = false,
					hidden = { file_browser = true, folder_browser = true },
					hide_parent_dir = true,
					follow_symlinks = true,
					hijack_netrw = true,
					mappings = {
						i = {
							["<C-t>"] = actions.select_tab, -- https://github.com/nvim-telescope/telescope-file-browser.nvim/issues/250
							["<M-g>"] = grep_in_dir,
							["<C-e>"] = path_toggle,
							["<C-i>"] = fb_actions.toggle_respect_gitignore,
						},
						n = {
							["-"] = fb_actions.goto_parent_dir,
							t = actions.select_tab,
							T = fb_actions.change_cwd,
							["<M-g>"] = grep_in_dir,
							["<C-e>"] = path_toggle,
							["<C-i>"] = fb_actions.toggle_respect_gitignore,
							["<C-p>"] = actions.move_selection_previous,
							["<C-n>"] = actions.move_selection_next,
						},
					},
				},
			},
		}

		vim.keymap.set("v", "<M-g>", function()
			vim.cmd('normal! "vy')
			local visual_selection = vim.fn.getreg("v"):gsub("\n", "")
			telescope.extensions.live_grep_args.live_grep_args({
				default_text = visual_selection,
			})
		end, { noremap = true, silent = true })

		telescope.setup(opts)
		-- telescope.load_extension("cscope")
		telescope.load_extension("file_browser")
		telescope.load_extension("find_pickers")
		telescope.load_extension("fzf")
		telescope.load_extension("live_grep_args")
		telescope.load_extension("lazy")
	end,
}
