local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<Leader>a", mark.add_file)
vim.keymap.set("n", "<Leader>L", ui.toggle_quick_menu)

vim.keymap.set("n", "<Leader>h", function() ui.nav_file(1) end)
vim.keymap.set("n", "<Leader>t", function() ui.nav_file(2) end)
vim.keymap.set("n", "<Leader>n", function() ui.nav_file(3) end)
vim.keymap.set("n", "<Leader>s", function() ui.nav_file(4) end)
