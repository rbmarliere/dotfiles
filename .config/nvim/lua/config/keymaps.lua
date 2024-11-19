local opts = { noremap = true }

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", opts)

local qf = require("utils.quickfix")
vim.api.nvim_create_user_command("ToggleQf", qf.toggle_qf, { nargs = 0 })
vim.api.nvim_create_user_command("SaveQf", qf.save_qf, { nargs = 1 })

vim.keymap.set("n", "<Leader>qs", ":SaveQf " .. vim.fn.stdpath("data") .. "/qf/", opts)
vim.keymap.set("n", "<Leader>qr", ":source " .. vim.fn.stdpath("data") .. "/qf/", opts)
vim.keymap.set("n", "<Leader>qd", ":!rm " .. vim.fn.stdpath("data") .. "/qf/", opts)
vim.keymap.set("n", "<Leader>q", ":ToggleQf<CR>", opts)
vim.keymap.set("n", "<Leader>Q", ":cexpr []<CR>:cclose<CR>", opts)
vim.keymap.set("n", "<Leader>pt", ":set spelllang=pt_br<CR>", opts)
vim.keymap.set("n", "<Leader>en", ":set spelllang=en<CR>", opts)
