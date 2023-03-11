local toggle_ui = function()
  local bufname = vim.fn.bufname()

  if bufname == '' then
    return
  end

  local curpos = vim.fn.getcurpos()
  vim.cmd.tabedit(bufname)
  vim.fn.setpos('.', curpos)

  local widgets = require("dap.ui.widgets")
  local dap = require("dap")

  widgets.sidebar(widgets.scopes, { width = 90 }).open()

  dap.repl.close()
  dap.repl.open({ width = 150 }, "vsplit")
end

local opts = { silent = true }
vim.keymap.set("n", "<C-x>", toggle_ui, opts)
vim.keymap.set("n", "<F10>", ":lua require'dap'.step_over()<CR>", opts)
vim.keymap.set("n", "<F11>", ":lua require'dap'.step_into()<CR>", opts)
vim.keymap.set("n", "<F12>", ":lua require'dap'.step_out()<CR>", opts)
vim.keymap.set("n", "<F4>", ":lua require'dap'.close()<CR>", opts)
vim.keymap.set("n", "<F5>", ":lua require'dap'.continue()<CR>", opts)
vim.keymap.set("n", "<Leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('condition: '))<CR>", opts)
vim.keymap.set("n", "<Leader>b", ":lua require'dap'.toggle_breakpoint()<CR>", opts)
vim.keymap.set("n", "<Leader>dl", ":lua require'dap'.run_last()<CR>", opts)
vim.keymap.set("n", "<Leader>lb", ":lua require'dap'.list_breakpoints()<CR>:copen<CR>", opts)
vim.keymap.set("n", "<Leader>lp", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('message: '))<CR>", opts)
