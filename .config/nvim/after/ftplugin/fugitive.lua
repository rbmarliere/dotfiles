local opts = { noremap = true }

vim.keymap.set("n", "<Leader>sa", ":Git stash apply<CR>", opts)
vim.keymap.set("n", "<Leader>sx", ":Git stash<CR>", opts)
vim.keymap.set("n", "<Leader>pl", ":Git pull<CR>", opts)
vim.keymap.set("n", "<Leader>px", ":Git push<CR>", opts)
