return {
	"nvim-treesitter/nvim-treesitter-context",
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })()
		end,
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "comment", "markdown", "markdown_inline", "gotmpl" },
				highlight = {
					enable = true,
				},
				auto_install = true,
			})
		end,
	},
}
