local opts = { noremap = true }

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", opts)
vim.keymap.set("n", "<Leader>M", ":!get_maintainer.pl % | tee >(wl-copy -p)<CR>", opts)

