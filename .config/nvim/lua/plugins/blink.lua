return {
	"saghen/blink.cmp",
	version = "v0.*",
	dependencies = {
		{
			"garymjr/nvim-snippets",
			keys = {
				{
					"<Tab>",
					function()
						if vim.snippet.active({ direction = 1 }) then
							vim.schedule(function()
								vim.snippet.jump(1)
							end)
							return
						end
						return "<Tab>"
					end,
					expr = true,
					silent = true,
					mode = "i",
				},
				{
					"<Tab>",
					function()
						vim.schedule(function()
							vim.snippet.jump(1)
						end)
					end,
					expr = true,
					silent = true,
					mode = "s",
				},
				{
					"<S-Tab>",
					function()
						if vim.snippet.active({ direction = -1 }) then
							vim.schedule(function()
								vim.snippet.jump(-1)
							end)
							return
						end
						return "<S-Tab>"
					end,
					expr = true,
					silent = true,
					mode = { "i", "s" },
				},
			},
		},
	},
	opts = {
		keymap = { preset = "default" },
		signature = { enabled = true },
		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono",
		},
		completion = {
			menu = {
				-- ExtraWhiteSpace is red in alabaster theme, disable it here
				winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None,ExtraWhiteSpace:Normal",
			},
		},
	},
}
