return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/vim-vsnip",
			-- sources
			"davidsierradz/cmp-conventionalcommits",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-vsnip",
			{ "tzachar/cmp-fuzzy-buffer", dependencies = { "tzachar/fuzzy.nvim" } },
			{ "tzachar/cmp-fuzzy-path", dependencies = { "tzachar/fuzzy.nvim" } },
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				preselect = cmp.PreselectMode.None,
				snippet = {
					expand = function(args)
						vim.fn["vsnip#anonymous"](args.body)
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
					{ name = "vsnip" },
					{ name = "nvim_lsp" },
					{ name = "nvim_lsp_signature_help" },
					{ name = "nvim_lua" },
					{ name = "fuzzy_buffer" },
					{
						name = "fuzzy_path",
						option = {
							fd_cmd = { "fdfind", "-d", "20", "-p" }, -- fd-find in Debian is /usr/bin/fdfind
						},
					},
				}),
				sorting = {
					priority_weight = 2,
					comparators = {
						require("cmp_fuzzy_path.compare"),
						cmp.config.compare.offset,
						cmp.config.compare.exact,
						-- cmp.config.compare.scopes,
						cmp.config.compare.score,
						cmp.config.compare.recently_used,
						cmp.config.compare.locality,
						cmp.config.compare.kind,
						-- cmp.config.compare.sort_text,
						cmp.config.compare.length,
						cmp.config.compare.order,
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
					{
						name = "fuzzy_path",
						option = {
							fd_cmd = { "fdfind", "-d", "20", "-p" }, -- fd-find in Debian is /usr/bin/fdfind
						},
					},
				}),
			})
			cmp.setup.filetype("gitcommit", {
				sources = cmp.config.sources({
					{ name = "conventionalcommits" },
					{ name = "fuzzy_buffer" },
				}),
			})
		end,
	},
}
