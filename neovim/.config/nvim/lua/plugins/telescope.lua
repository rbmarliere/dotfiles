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
		"rbmarliere/telescope-cscope.nvim",
		"keyvchan/telescope-find-pickers.nvim",
		"nvim-telescope/telescope-live-grep-args.nvim",
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	keys = {
		{ "<C-Space>", ":Telescope find_pickers<CR>" },
		{ "<C-p>", ":Telescope git_files<CR>" },
	},
	config = function()
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")

		local picker_config = {}
		for b, _ in pairs(builtin) do
			picker_config[b] = {
				fname_width = 60,
				symbol_width = 50,
				symbol_type_width = 15,
			}
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
			},
		}

		telescope.setup(opts)

		telescope.load_extension("live_grep_args")
		telescope.load_extension("fzf")
		telescope.load_extension("find_pickers")
		telescope.load_extension("cscope")

		-- grep in current netrw directory
		vim.api.nvim_set_keymap(
			"n",
			"<M-p>",
			":lua require('telescope').extensions.live_grep_args.live_grep_args({search_dirs={vim.fn['netrw#Call']('NetrwFile', '.')}})<CR>",
			{ noremap = true, silent = true }
		)
	end,
}
