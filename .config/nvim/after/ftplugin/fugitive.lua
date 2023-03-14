local opts = { noremap = true }

vim.keymap.set("n", "<Leader>pl", ":Git pull --rebase<CR>", opts)
vim.keymap.set("n", "<Leader>px", ":Git push<CR>", opts)
