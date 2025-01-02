return {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	ft = "markdown",
	enabled = function()
		return vim.fn.isdirectory(vim.fn.expand("~/notes")) == 1
	end,
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	init = function()
		vim.opt.conceallevel = 1
	end,
	keys = {
		{ "<leader>oo", ":ObsidianQuickSwitch<CR>" },
		{ "<leader>on", ":ObsidianNew<CR>" },
		{ "<leader>ot", ":ObsidianToday<CR>" },
		{ "<leader>O", ":Obsidian" },
	},
	opts = {
		workspaces = {
			{
				name = "notes",
				path = "~/notes",
			},
		},
		disable_frontmatter = true,
		notes_subdir = "inbox",
		daily_notes = {
			folder = "journal/",
			default_tags = {},
			date_format = "%Y/%m-%B/%Y-%m-%d-%A",
		},
		completion = {
			nvim_cmp = true,
			min_chars = 2,
		},
		note_id_func = function(title)
			local suffix = ""
			if title == nil then
				for _ = 1, 4 do
					suffix = suffix .. string.char(math.random(65, 90))
				end
			end
			return title
		end,
		attachments = {
			img_folder = "assets",
		},
	},
}
