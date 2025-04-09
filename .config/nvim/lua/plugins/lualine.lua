local colors = require("utils.colors")

local red = { bg = colors.red, fg = colors.white, gui = "bold" }
local green = { bg = colors.green, fg = colors.black }
local lightgreen = { bg = colors.lightgreen, fg = colors.darkgray }

local my_theme = {
	normal = {
		a = { bg = colors.darkgray, fg = colors.white, gui = "bold" },
		b = green,
		c = green,
	},
	insert = {
		a = red,
		b = green,
		c = green,
	},
	visual = {
		a = { bg = colors.purple, fg = colors.white, gui = "bold" },
		b = green,
		c = green,
	},
	replace = {
		a = { bg = colors.yellow, fg = colors.white, gui = "bold" },
		b = green,
		c = green,
	},
	command = {
		a = { bg = colors.blue, fg = colors.black, gui = "bold" },
		b = green,
		c = green,
	},
	inactive = {
		a = { bg = colors.lightgreen, fg = colors.inactivegray },
		b = { bg = colors.lightergreen, fg = colors.inactivegray },
		c = { bg = colors.lightergreen, fg = colors.inactivegray },
	},
}

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {},
	config = function()
		-- https://github.com/nvim-lualine/lualine.nvim/wiki/Component-snippets#changing-filename-color-based-on--modified-status
		local custom_fname = require("lualine.components.filename"):extend()
		local highlight = require("lualine.highlight")
		local default_status_colors = { saved = colors.green, modified = colors.orange }
		function custom_fname:init(options)
			custom_fname.super.init(self, options)
			self.status_colors = {
				saved = highlight.create_component_highlight_group(
					{ bg = default_status_colors.saved },
					"filename_status_saved",
					self.options
				),
				modified = highlight.create_component_highlight_group(
					{ bg = default_status_colors.modified },
					"filename_status_modified",
					self.options
				),
			}
			-- if self.options.color == nil then
			-- 	self.options.color = ""
			-- end
		end
		function custom_fname:update_status()
			local data = custom_fname.super.update_status(self)
			data = highlight.component_format_highlight(
				vim.bo.modified and self.status_colors.modified or self.status_colors.saved
			) .. data
			return data
		end

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
					-- statusline = 1000,
					-- tabline = 1000,
					-- winbar = 1000,
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
				lualine_b = {
					{
						custom_fname,
						path = 1,
					},
				},
				lualine_c = { }, -- "branch"
				lualine_x = { "diff", "diagnostics" }, -- "encoding", "fileformat", "fileformat", "filetype" },
				lualine_y = { "progress", "searchcount" },
				lualine_z = { "location", "selectioncount" },
			},
			inactive_sections = {
				lualine_a = {
					{
						custom_fname,
						path = 1,
					},
				},
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {
				lualine_a = {
					{
						"tabs",
						tab_max_length = 10, -- Maximum width of each tab. The content will be shorten dynamically (example: apple/orange -> a/orange)
						max_length = vim.o.columns, -- Maximum width of tabs component.
						-- Note:
						-- It can also be a function that returns
						-- the value of `max_length` dynamically.
						mode = 1, -- 0: Shows tab_nr
						-- 1: Shows tab_name
						-- 2: Shows tab_nr + tab_name

						path = 1, -- 0: just shows the filename
						-- 1: shows the relative path and shorten $HOME to ~
						-- 2: shows the full path
						-- 3: shows the full path and shorten $HOME to ~

						-- Automatically updates active tab color to match color of other components (will be overridden if buffers_color is set)
						use_mode_colors = false,

						tabs_color = {
							-- Same values as the general color option can be used here.
							active = lightgreen, -- Color for active tab.
							inactive = green, -- Color for inactive tab.
						},

						show_modified_status = true, -- Shows a symbol next to the tab name if the file has been modified.
						symbols = {
							modified = "[+]", -- Text to show when the file is modified.
						},

						fmt = function(name, context)
							-- Show + if buffer is modified in tab
							local buflist = vim.fn.tabpagebuflist(context.tabnr)
							local winnr = vim.fn.tabpagewinnr(context.tabnr)
							local bufnr = buflist[winnr]
							-- local mod = vim.fn.getbufvar(bufnr, "&mod")
							-- return name .. (mod == 1 and " +" or "")

							local bufft = vim.api.nvim_buf_get_option(bufnr, "filetype")
							if string.match(name, "^fugitive:") then
								name = "G"
							elseif string.match(bufft, "^git$") then
								name = "g"
							end

							return name
						end,
					},
				},
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
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
