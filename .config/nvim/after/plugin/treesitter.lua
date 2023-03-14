require("nvim-treesitter.configs").setup({
  highlight = {
    enable = true,
  },
  auto_install = true
})
vim.api.nvim_set_hl(0, "TreesitterContextBottom", { underline = true, sp = "Cyan" })
