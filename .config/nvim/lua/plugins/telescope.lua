return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",
	dependencies = {
		"nvim-telescope/telescope-live-grep-args.nvim",
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	opts = {
		defaults = {
			border = true,
			borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
			sorting_strategy = "ascending",
		},
		pickers = {
			find_files = {
				find_command = { "rg", "--files", "--hidden", "--glob", "!.git", "--no-ignore-vcs" },
			},
			lsp_workspace_symbols = {
				fname_width = 60,
				symbol_width = 50,
				symbol_type_width = 15,
			},
			lsp_dynamic_workspace_symbols = {
				fname_width = 60,
				symbol_width = 50,
				symbol_type_width = 15,
			},
			man_pages = {
				sections = { "1", "2", "3", "4", "5", "6", "7", "8", "9" },
			},
		},
		extensions = {
			live_grep_args = {
				vimgrep_arguments = {
					"rg",
					"--pcre2",
					"--glob",
					"!.git",
					"--hidden",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
				},
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
	},
	keys = {
		{ "<C-Space>", ":Telescope<CR>" },
		{ "<C-p>", ":Telescope git_files<CR>" },
		{ "<M-p>", ":Telescope find_files<CR>" },
		{ "<M-P>", ":Telescope live_grep_args<CR>" },
	},
	config = function(_, opts)
		require("telescope").setup(opts)
		require("telescope").load_extension("live_grep_args")
		require("telescope").load_extension("fzf")
	end
}
