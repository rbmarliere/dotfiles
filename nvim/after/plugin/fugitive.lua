local call_fugitive = function()
  vim.cmd([[tab Git]])
  vim.cmd([[tabm 0]])
end

vim.keymap.set("n", "<Leader>g", call_fugitive)
