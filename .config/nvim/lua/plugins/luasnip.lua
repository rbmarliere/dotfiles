return {
	"L3MON4D3/LuaSnip",
	tag = "v2.2.0",
	build = "make install_jsregexp",
	config = function(_, opts)
		local ls = require("luasnip")
		ls.setup(opts)
		require("luasnip.loaders.from_lua").load({
			paths = vim.fn.stdpath("config") .. "/lua/snippets",
		})
		ls.filetype_extend("mail", { "linux" })
		ls.filetype_extend("gitcommit", { "linux" })
	end,
}
