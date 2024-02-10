local colors = require("utils.colors")

local my_theme = {
	normal = {
		a = { bg = colors.darkgray, fg = colors.white, gui = "bold" },
		b = { bg = colors.lightgreen, fg = colors.darkgray },
		c = { bg = colors.green, fg = colors.black },
	},
	insert = {
		a = { bg = colors.purple, fg = colors.white, gui = "bold" },
		b = { bg = colors.lightgreen, fg = colors.darkgray },
		c = { bg = colors.green, fg = colors.black },
	},
	visual = {
		a = { bg = colors.red, fg = colors.white, gui = "bold" },
		b = { bg = colors.lightgreen, fg = colors.darkgray },
		c = { bg = colors.green, fg = colors.black },
	},
	replace = {
		a = { bg = colors.yellow, fg = colors.white, gui = "bold" },
		b = { bg = colors.lightgreen, fg = colors.darkgray },
		c = { bg = colors.green, fg = colors.black },
	},
	command = {
		a = { bg = colors.blue, fg = colors.black, gui = "bold" },
		b = { bg = colors.lightgreen, fg = colors.darkgray },
		c = { bg = colors.green, fg = colors.black },
	},
	inactive = {
		a = { bg = colors.lightgreen, fg = colors.inactivegray },
		b = { bg = colors.lightgreen, fg = colors.inactivegray },
		c = { bg = colors.lightgreen, fg = colors.inactivegray },
	},
}

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {},
	config = function()
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = my_theme,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = false,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				},
			},
			sections = {
				lualine_a = {
					{
						"mode",
						fmt = function(str)
							return str:sub(1, 1)
						end,
					},
				},
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "filename" },
				lualine_x = { "encoding" }, --"fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {
				"fugitive",
				"man",
				"nvim-dap-ui",
				"quickfix",
			},
		})
	end,
}
