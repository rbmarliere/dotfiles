local colors = require("utils.colors")

local my_theme = {
	WhiteSpaceBol = { bg = colors.white },
	SignColumn = { bg = "none" },
	Normal = { bg = "none" },
	NormalNC = { bg = "none" },
	-- NormalFloat = { bg = colors.white },
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
	Todo = { fg = colors.lighterwhite, bg = colors.purple, bold = true },
}

local create_groups = function()
	-- helper to set current window highlight
	local set_winhightlight = function(hl)
		local win = vim.api.nvim_get_current_win()
		local config = vim.api.nvim_win_get_config(win)
		if config.relative == "" then
			-- this is a not floating window
			vim.api.nvim_set_option_value("winhighlight", hl, { win = win })
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
			if tmux ~= vim.NIL and not string.match(tmux, "mail") then
				vim.fn.system("tmux rename-window nvim")
			end
		end,
	})
	vim.api.nvim_create_autocmd("VimLeave", {
		group = "MyHighlights",
		callback = function()
			local tmux = vim.fn.getenv("TMUX")
			if tmux ~= vim.NIL and not string.match(tmux, "mail") then
				vim.fn.system("tmux rename-window bash")
			end
		end,
	})
end

return {
	"p00f/alabaster.nvim",
	-- lazy = false,
	priority = 1000,
	config = function()
		vim.opt.termguicolors = true
		if os.getenv("TERM") == "linux" or os.getenv("TMUX_OUTER_TERM") == "linux" then
			vim.opt.background = "dark"
		else
			vim.opt.background = "light"
			vim.cmd.colorscheme("alabaster")
			for group, settings in pairs(my_theme) do
				vim.api.nvim_set_hl(0, group, settings)
			end
			vim.api.nvim_set_hl(0, "@comment.error", { link = "Todo" })
			vim.api.nvim_set_hl(0, "@comment.note", { link = "Todo" })
			vim.api.nvim_set_hl(0, "@comment.todo", { link = "Todo" })
			vim.api.nvim_set_hl(0, "@comment.warning", { link = "Todo" })
			vim.api.nvim_set_hl(0, "@text.note", { link = "Todo" })
			create_groups()
		end
	end,
}
