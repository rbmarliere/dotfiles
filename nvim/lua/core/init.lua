require("core.map")
require("core.packer")
require("core.set")
require("core.tabmove")

local autocmd = vim.api.nvim_create_autocmd

autocmd({ "FileType" }, {
  pattern = "html",
  command = [[setlocal tabstop=2 softtabstop=2 shiftwidth=2]]
})
autocmd({ "FileType" }, {
  pattern = "typescript",
  command = [[setlocal tabstop=2 softtabstop=2 shiftwidth=2]]
})
autocmd({ "FileType" }, {
  pattern = "lua",
  command = [[setlocal tabstop=2 softtabstop=2 shiftwidth=2]]
})
