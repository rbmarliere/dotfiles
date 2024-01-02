return {
	"nvim-treesitter/nvim-treesitter-context",
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })()
		end,
		config = function()
			require("nvim-treesitter.configs").setup({
				highlight = {
					enable = true,
				},
				auto_install = true,
			})
			-- vim.api.nvim_set_hl(0, "TreesitterContextBottom", { underline = true, sp = "Cyan" })
		end,
	},
}
