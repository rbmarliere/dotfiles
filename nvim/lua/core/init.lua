require("core.map")
require("core.packer")
require("core.set")
require("core.tabmove")

local autocmd = vim.api.nvim_create_autocmd

autocmd({ "filetype" }, {
  pattern = "html",
  command = [[setlocal tabstop=2 softtabstop=2 shiftwidth=2]]
})
autocmd({ "filetype" }, {
  pattern = "typescript",
  command = [[setlocal tabstop=2 softtabstop=2 shiftwidth=2]]
})
autocmd({ "filetype" }, {
  pattern = "lua",
  command = [[setlocal tabstop=2 softtabstop=2 shiftwidth=2]]
})
autocmd({ "filetype" }, {
  pattern = "netrw",
  command = [[nnoremap <buffer> <Space> :Ntree<CR>]]
})
autocmd({ "filetype" }, {
  pattern = "netrw",
  command = [[nnoremap <buffer> <C-LeftMouse> :Ntree<CR>]]
})
