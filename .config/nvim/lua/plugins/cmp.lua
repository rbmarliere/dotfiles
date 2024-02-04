return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"L3MON4D3/LuaSnip",
			-- sources
			"davidsierradz/cmp-conventionalcommits",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			{ "tzachar/cmp-fuzzy-buffer", dependencies = { "tzachar/fuzzy.nvim" } },
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				preselect = cmp.PreselectMode.None,
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					documentation = {
						winhighlight = "Normal:Pmenu",
					},
				},
				mapping = cmp.mapping.preset.insert({
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = false }),
				}),
				sources = cmp.config.sources({
					{ name = "luasnip" },
					{ name = "nvim_lsp" },
					{ name = "nvim_lsp_signature_help" },
					{ name = "nvim_lua" },
					{ name = "fuzzy_buffer" },
					{ name = "path" },
				}),
				sorting = {
					comparators = {
						cmp.config.compare.recently_used,
					},
				},
			})
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "fuzzy_buffer" },
				},
			})
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "cmdline" },
					{ name = "path" },
				}),
			})
			cmp.setup.filetype("gitcommit", {
				sources = cmp.config.sources({
					{ name = "luasnip" },
					{ name = "conventionalcommits" },
					{ name = "fuzzy_buffer" },
				}),
			})
		end,
	},
}
