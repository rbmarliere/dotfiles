vim.cmd[[ imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' ]]
vim.cmd[[ inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr> ]]
vim.cmd[[ snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr> ]]
vim.cmd[[ snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr> ]]

require("luasnip.loaders.from_vscode").lazy_load { paths = { "~/git/python-snippets" } }
require("luasnip.loaders.from_vscode").lazy_load { paths = { "~/git/vscode-angular-snippets" } }
