return {
	"ellisonleao/gruvbox.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		vim.opt.background = "light"
		require("gruvbox").setup({
			terminal_colors = false, -- add neovim terminal colors
			undercurl = true,
			underline = true,
			bold = true,
			italic = {
				strings = false,
				emphasis = false,
				comments = false,
				operators = false,
				folds = false,
			},
			strikethrough = false,
			invert_selection = false,
			invert_signs = false,
			invert_tabline = false,
			invert_intend_guides = false,
			inverse = true, -- invert background for search, diffs, statuslines and errors
			contrast = "hard", -- can be "hard", "soft" or empty string
			dim_inactive = false,
			transparent_mode = true,
			palette_overrides = {},
			overrides = {
				WhiteSpaceBol = { bg = "#d5c4a1" },
				SignColumn = { bg = "none" },
				Normal = { bg = "none" },
				NormalFloat = { bg = "#d5c4a1" },
				FloatBorder = { fg = "#6c782e", bg = "none" },
				StatusLine = { fg = "#6c782e", bg = "black" },
				StatusLineNC = { fg = "#a9b665", bg = "#7c6f64" },
				VertSplit = { fg = "#6c782e", bg = "none" },
				TabLine = { fg = "#a9b665", bg = "#6c782e" },
				TabLineSel = { fg = "black", bg = "#6c782e" },
				TabLineFill = { fg = "#6c782e", bg = "#6c782e" },
				ColorColumn = { bg = "#f5f2ed" },
				CursorColumn = { bg = "#6c782e" },
				CursorLine = { fg = "black", bg = "#6c782e" },
				PmenuSel = { fg = "black", bg = "#6c782e" },
				TelescopePromptNormal = { bg = "#d5c4a1" },
				TelescopePromptBorder = { fg= "#6c782e", bg = "#d5c4a1" },
				TelescopePreviewNormal = { bg = "#d5c4a1" },
				TelescopePreviewBorder = { fg= "#6c782e", bg = "#d5c4a1" },
				TelescopeResultsNormal = { bg = "#d5c4a1" },
				TelescopeResultsBorder = { fg= "#6c782e", bg = "#d5c4a1" },
				DiagnosticVirtualTextError = { fg = "#cc241d", bg = "#d5c4a1" },
				DiagnosticVirtualTextWarn = { fg = "#b57614", bg = "#d5c4a1" },
				DiagnosticVirtualTextInfo = { fg = "#458588", bg = "#d5c4a1" },
				DiagnosticVirtualTextHint = { fg = "#689d6a", bg = "#d5c4a1" },
				DiagnosticVirtualTextOk = { bg = "#d5c4a1" },
			},
		})
		vim.cmd.colorscheme("gruvbox")
	end,
}
