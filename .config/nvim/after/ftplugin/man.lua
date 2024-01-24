local opts = { silent = true, buffer = true, nowait = true }
vim.keymap.set("n", "q", ":lclose<CR><C-W>q", opts)
vim.opt_local.laststatus = 0
vim.opt_local.modifiable = false
vim.opt_local.modified = false
vim.opt_local.buftype = "nofile"
