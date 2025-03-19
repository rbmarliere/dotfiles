return {
	"saghen/blink.cmp",
	version = "*",
	-- build = 'cargo build --release',
	dependencies = {
		{
			"folke/lazydev.nvim",
			ft = "lua", -- only load on lua files
			opts = {
				library = {
					-- See the configuration section for more details
					-- Load luvit types when the `vim.uv` word is found
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
	},
	opts = {
		enabled = function()
			return vim.bo.buftype ~= "prompt" and vim.b.completion ~= false
		end,
		keymap = { preset = "default" },
		signature = { enabled = true },
		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono",
		},
		completion = {
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 500,
			},
			menu = {
				-- ExtraWhiteSpace is red in alabaster theme, disable it here
				winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None,ExtraWhiteSpace:Normal",
			},
		},
		sources = {
			default = { "lazydev", "lsp", "path", "snippets", "buffer" },
			providers = {
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					-- make lazydev completions top priority (see `:h blink.cmp`)
					score_offset = 100,
				},
				snippets = {
					opts = {
						search_paths = {
							vim.fn.stdpath("config") .. "/snippets",
							-- per project:
							vim.fn.system("git rev-parse --path-format=absolute --show-toplevel 2>/dev/null || git rev-parse --path-format=absolute --git-common-dir"):gsub("\n", "") .. "/snippets",
							"snippets",
							".snippets",
						},
					},
				},
			},
		},
	},
}
