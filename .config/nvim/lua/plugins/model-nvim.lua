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
		{ "<C-m>z", ":tab Mchat zephyr<CR>", mode = "n" },
		{ "<C-m><Space>", ":Mchat<CR>G", mode = "n" },
	},
	config = function()
		local chats = require("model.prompts.chats")
		local llamacpp = require("model.providers.llamacpp")

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
				zephyr = vim.tbl_deep_extend("force", vim.deepcopy(chats["llamacpp:zephyr"]), {
					options = {
						-- model = "zephyr-7b-beta/ggml-model-f16.gguf",
						model = nil, -- (nil disables autostart and expects a running server @127.0.0.1:8080
						args = {},
					},
				}),
			},
		})

		llamacpp.setup({
			binary = "~/models/llama.cpp/server",
			models = "~/models/",
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "mchat" },
			callback = function()
				-- vim.cmd.syntax("off")
				vim.cmd.setlocal("foldmethod=manual")
			end,
		})
	end,
}
