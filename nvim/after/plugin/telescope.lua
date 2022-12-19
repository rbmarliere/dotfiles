local opts = { noremap = true, silent = true }

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<Leader>pf', builtin.find_files, opts)
vim.keymap.set('n', '<C-p>', builtin.git_files, opts)
vim.keymap.set('n', '<Leader>fg', builtin.live_grep, opts)
