local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"L3MON4D3/LuaSnip",
			-- sources
			"davidsierradz/cmp-conventionalcommits",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-path",
			"petertriho/cmp-git",
			"saadparwaiz1/cmp_luasnip",
			{ "tzachar/cmp-fuzzy-buffer", dependencies = { "tzachar/fuzzy.nvim" } },
			-- "hrsh7th/cmp-omni",
		},
		config = function()
			-- for cmp-omni
			-- vim.cmd("filetype plugin on")
			-- vim.o.omnifunc = "syntaxcomplete#Complete"

			local ls = require("luasnip")
			local cmp = require("cmp")
			cmp.setup({
				preselect = cmp.PreselectMode.None,
				snippet = {
					expand = function(args)
						ls.lsp_expand(args.body)
					end,
				},
				window = {
					documentation = {
						winhighlight = "Normal:Pmenu",
					},
				},
				formatting = {
					format = function(entry, vim_item)
						-- entry maximum width
						vim_item.abbr = string.sub(vim_item.abbr, 1, 30)
						return vim_item
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = false }),
					["<C-n>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
						-- that way you will only jump inside the snippet region
						elseif ls.expand_or_jumpable() then
							ls.expand_or_jump()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<C-p>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif ls.jumpable(-1) then
							ls.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "luasnip" },
					{ name = "nvim_lsp_signature_help" },
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
					{ name = "git" },
					-- { name = "omni", keyword_length = 0 },
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
					{ name = "buffer" },
				},
			})
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "cmdline" },
				}, {
					{ name = "path" },
				}),
			})
			cmp.setup.filetype("gitcommit", {
				sources = cmp.config.sources({
					{ name = "luasnip" },
					{ name = "git" },
					{ name = "conventionalcommits" },
					{ name = "fuzzy_buffer" },
					-- {
					-- 	name = "omni",
					-- 	option = {
					-- 		disable_omnifuncs = { "v:lua.vim.lsp.omnifunc" },
					-- 	},
					-- },
				}),
			})
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

			require("cmp_git").setup({
				git = {
					commits = {
						limit = 5000,
						format = {
							insertText = function(trigger_char, commit)
								return commit.sha .. ' ("' .. commit.title .. '")'
							end,
						},
						sha_length = 12,
					},
				},
				gitlab = {
					hosts = { "gitlab.suse.de" },
				},
			})

			-- why am I having to force this, should be auto...?
			-- vim.api.nvim_create_autocmd("FileType", {
			-- 	pattern = "gitcommit",
			-- 	callback = function()
			-- 		vim.bo.omnifunc = "rhubarb#Complete"
			-- 		vim.bo.omnifunc = "gitlab#omnifunc#handler"
			-- 	end,
			-- })
		end,
	},
}
