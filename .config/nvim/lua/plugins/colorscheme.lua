local colors = require("utils.colors")

local my_theme = {
	WhiteSpaceBol = { bg = colors.white },
	SignColumn = { bg = "none" },
	Normal = { bg = "none" },
	NormalFloat = { bg = colors.white },
	FloatBorder = { fg = colors.green, bg = "none" },
	StatusLine = { fg = colors.green, bg = colors.black },
	StatusLineNC = { fg = colors.lightgreen, bg = colors.lightgray },
	VertSplit = { fg = colors.green, bg = "none" },
	TabLine = { fg = colors.lightgreen, bg = colors.green },
	TabLineSel = { fg = colors.black, bg = colors.green },
	TabLineFill = { fg = colors.green, bg = colors.green },
	ColorColumn = { bg = colors.lightwhite },
	CursorColumn = { bg = colors.green },
	CursorLine = { fg = colors.black, bg = colors.green },
	PmenuSel = { fg = colors.black, bg = colors.green },
	TelescopePromptNormal = { bg = colors.white },
	TelescopePromptBorder = { fg = colors.green, bg = colors.white },
	TelescopePreviewNormal = { bg = colors.white },
	TelescopePreviewBorder = { fg = colors.green, bg = colors.white },
	TelescopeResultsNormal = { bg = colors.white },
	TelescopeResultsBorder = { fg = colors.green, bg = colors.white },
	TelescopePromptCounter = { fg = colors.green },
	DiagnosticVirtualTextError = { fg = colors.red, bg = colors.white },
	DiagnosticVirtualTextWarn = { fg = colors.yellow, bg = colors.white },
	DiagnosticVirtualTextInfo = { fg = colors.blue, bg = colors.white },
	DiagnosticVirtualTextHint = { fg = colors.cyan, bg = colors.white },
	DiagnosticVirtualTextOk = { bg = colors.white },
}

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
			overrides = my_theme,
		})
		vim.cmd.colorscheme("gruvbox")
	end,
}
