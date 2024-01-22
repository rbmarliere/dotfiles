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
			preview = {
				treesitter = false,
			},
			layout_strategy = "center",
			layout_config = {
				anchor = "N",
				height = 0.35,
				width = 0.80,
			},
			border = true,
			-- borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
			borderchars = { "─", "", "", "", "─", "─", "", "" },
			sorting_strategy = "ascending",
		},
		pickers = {
			find_files = {
				find_command = { "rg", "--files", "--hidden", "--glob", "!.git", "--no-ignore-vcs" },
			},
			-- lsp_dynamic_workspace_symbols = {
			-- 	fname_width = 100,
			-- 	symbol_width = 50,
			-- 	symbol_type_width = 15,
			-- },
		},
		extensions = {
			live_grep_args = {
				vimgrep_arguments = {
					"rg",
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
		{ "<C-Space>", ":Telescope lsp_document_symbols<CR>" },
		{ "<C-q>", ":Telescope quickfix<CR>" },
		{ "<C-p>", ":Telescope git_files<CR>" },
		{ "<Leader>dd", ":Telescope diagnostics<CR>" },
		{ "<M-1>", ":Telescope lsp_definitions<CR>" },
		{ "<M-2>", ":Telescope lsp_dynamic_workspace_symbols<CR>" },
		{ "<M-P>", ":Telescope live_grep_args<CR>" },
		{ "<M-p>", ":Telescope find_files<CR>" },
	},
	config = function(_, opts)
		require("telescope").setup(opts)
		require("telescope").load_extension("live_grep_args")
		require("telescope").load_extension("fzf")
	end
}
