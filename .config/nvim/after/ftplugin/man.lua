local opts = { silent = true, buffer = true, nowait = true }
vim.keymap.set("n", "q", ":lclose<CR><C-W>q", opts)
vim.opt_local.laststatus = 0
