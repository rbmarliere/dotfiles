local opts = { silent = true }

vim.keymap.set("n", "<C-x>", ":lua require'dap'.repl.toggle()<CR><C-w>j", opts)
vim.keymap.set("n", "<F10>", ":lua require'dap'.step_over()<CR>", opts)
vim.keymap.set("n", "<F11>", ":lua require'dap'.step_into()<CR>", opts)
vim.keymap.set("n", "<F12>", ":lua require'dap'.step_out()<CR>", opts)
vim.keymap.set("n", "<F4>", ":lua require'dap'.close()<CR>", opts)
vim.keymap.set("n", "<F5>", ":lua require'dap'.continue()<CR>", opts)
vim.keymap.set("n", "<Leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('condition: '))<CR>", opts)
vim.keymap.set("n", "<Leader>b", ":lua require'dap'.toggle_breakpoint()<CR>", opts)
vim.keymap.set("n", "<Leader>dl", ":lua require'dap'.run_last()<CR>", opts)
vim.keymap.set("n", "<Leader>lb", ":lua require'dap'.list_breakpoints()<CR>:belowright copen<CR>", opts)
vim.keymap.set("n", "<Leader>lp", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('message: '))<CR>", opts)

local toggle_float = function()
  local widgets = require("dap.ui.widgets")
  widgets.centered_float(widgets.scopes)
end
vim.keymap.set("n", "<Leader><C-x>", toggle_float, opts)
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "dap-float",
  command = [[nnoremap <buffer><silent> q <cmd>close!<CR>]],
})
