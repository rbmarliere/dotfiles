return {
	"gsuuon/model.nvim",
	cmd = { "M", "Model", "Mchat" },
	init = function()
		vim.filetype.add({
			extension = {
				mchat = "mchat",
			},
		})
	end,
	ft = "mchat",
	keys = {
		{ "<C-m>4", ":tab Mchat gpt4<CR>", mode = "n" },
		{ "<C-m>g", ":tab Mchat openai<CR>", mode = "n" },
		{ "<C-m><Space>", ":Mchat<CR>", mode = "n" },
	},
	config = function()
		local chats = require("model.prompts.chats")
		require("model").setup({
			chats = {
				openai = vim.tbl_deep_extend("force", chats["openai"], {
					params = {
						model = "gpt-3.5-turbo-0125",
					},
				}),
				gpt4 = vim.tbl_deep_extend("force", chats["gpt4"], {
					params = {
						model = "gpt-4-0125-preview",
					},
				}),
			},
		})
	end,
}
