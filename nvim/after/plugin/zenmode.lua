require("zen-mode").setup({
  window = {
    width = 86,
    options = {
      number = true,
      relativenumber = true,
    },
  },
})

vim.keymap.set("n", "<Leader>z", ":lua require('zen-mode').toggle()<CR>")
