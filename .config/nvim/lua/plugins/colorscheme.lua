local colors = require("utils.colors")

local my_theme = {
	WhiteSpaceBol = { bg = colors.white },
	SignColumn = { bg = "none" },
	Normal = { bg = "none" },
	NormalNC = { bg = "none" },
	NormalFloat = { bg = colors.white },
	FloatBorder = { fg = colors.green, bg = "none" },
	StatusLine = { fg = colors.green, bg = colors.black },
	StatusLineNC = { fg = colors.lightgreen, bg = colors.lightgray },
	VertSplit = { fg = colors.green, bg = "none" },
	TabLine = { fg = colors.lightgreen, bg = colors.lightgreen },
	TabLineSel = { fg = colors.black, bg = colors.green },
	TabLineFill = { fg = colors.lightgreen, bg = colors.lightgreen },
	ColorColumn = { bg = colors.lightwhite },
	Cursor = { bg = "none" },
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
}

local create_groups = function()
	-- helper to set current window highlight
	local set_winhightlight = function(hl)
		local win = vim.api.nvim_get_current_win()
		local config = vim.api.nvim_win_get_config(win)
		if config.relative == "" then
			-- this is a not floating window
			vim.api.nvim_win_set_option(win, "winhighlight", hl)
		end
	end

	-- highlight groups used to set active window bg opaque and keep others transparent
	vim.api.nvim_set_hl(0, "Transparent", {
		bg = "none",
	})
	vim.api.nvim_set_hl(0, "LighterWhite", {
		bg = colors.lighterwhite,
	})
	vim.api.nvim_set_hl(0, "LightWhite", {
		bg = colors.lightwhite,
	})
	vim.api.nvim_set_hl(0, "White", {
		bg = colors.white,
	})
	vim.api.nvim_create_augroup("MyHighlights", { clear = true })
	vim.api.nvim_create_autocmd({ "VimEnter", "WinNew", "WinEnter", "BufEnter", "FocusGained" }, {
		group = "MyHighlights",
		pattern = "*",
		callback = function()
			set_winhightlight("Normal:LighterWhite,ColorColumn:LightWhite,NormalNC:White")
		end,
	})
	vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave", "FocusLost" }, {
		group = "MyHighlights",
		pattern = "*",
		callback = function()
			set_winhightlight("Normal:Transparent,ColorColumn:Transparent")
		end,
	})

	-- integration with tmux.conf window-renamed event hook
	vim.api.nvim_create_autocmd("VimEnter", {
		group = "MyHighlights",
		callback = function()
			local tmux = vim.fn.getenv("TMUX")
			if tmux ~= vim.NIL and not string.match(tmux, "neomutt") then
				vim.fn.system("tmux rename-window nvim")
			end
		end,
	})
	vim.api.nvim_create_autocmd("VimLeave", {
		group = "MyHighlights",
		callback = function()
			local tmux = vim.fn.getenv("TMUX")
			if tmux ~= vim.NIL and not string.match(tmux, "neomutt") then
				vim.fn.system("tmux rename-window bash")
			end
		end,
	})
end

-- return {
-- 	"ellisonleao/gruvbox.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		if os.getenv("TERM") == "linux" then
-- 			vim.opt.background = "dark"
-- 		else
-- 			require("gruvbox").setup({
-- 				terminal_colors = false, -- add neovim terminal colors
-- 				undercurl = true,
-- 				underline = true,
-- 				bold = true,
-- 				italic = {
-- 					strings = false,
-- 					emphasis = false,
-- 					comments = false,
-- 					operators = false,
-- 					folds = false,
-- 				},
-- 				strikethrough = false,
-- 				invert_selection = false,
-- 				invert_signs = false,
-- 				invert_tabline = false,
-- 				invert_intend_guides = false,
-- 				inverse = true, -- invert background for search, diffs, statuslines and errors
-- 				contrast = "hard", -- can be "hard", "soft" or empty string
-- 				dim_inactive = false,
-- 				transparent_mode = true,
-- 				palette_overrides = {},
-- 				overrides = my_theme,
-- 			})
-- 			vim.cmd.colorscheme("gruvbox")
-- 			vim.opt.background = "light"
-- 		end
-- 	end,
-- }

return {
	"p00f/alabaster.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		vim.opt.termguicolors = true
		vim.cmd.colorscheme("alabaster")
		for group, settings in pairs(my_theme) do
			vim.api.nvim_set_hl(0, group, settings)
		end
		if os.getenv("TERM") == "linux" then
			vim.opt.background = "dark"
		else
			vim.opt.background = "light"
		end
		create_groups()
	end,
}
