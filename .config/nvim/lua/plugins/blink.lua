return {
	"saghen/blink.cmp",
	version = "v0.*",
	opts = {
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
			providers = {
				snippets = {
					opts = {
						search_paths = {
							vim.fn.stdpath("config") .. "/snippets",
							"snippets", -- relative path, per-project
						},
					},
				},
			},
		},
	},
}
