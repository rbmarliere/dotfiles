local opts = { noremap = true }
vim.keymap.set("n", "<Leader>sa", ":Git stash apply<CR>", opts)
vim.keymap.set("n", "<Leader>sx", ":Git stash<CR>", opts)
vim.keymap.set("n", "<Leader>pl", ":Git pull --rebase<CR>", opts)
vim.keymap.set("n", "<Leader>px", ":Git push<CR>", opts)
vim.keymap.set("n", "<Leader>g", "<C-w>q", { noremap = true, buffer = true })
