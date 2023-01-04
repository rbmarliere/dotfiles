local opts = { silent = true }

vim.keymap.set("n", "<F4>", ":lua require'dap'.close()<CR>", opts)
vim.keymap.set("n", "<F5>", ":lua require'dap'.continue()<CR>", opts)
vim.keymap.set("n", "<F10>", ":lua require'dap'.step_over()<CR>", opts)
vim.keymap.set("n", "<F11>", ":lua require'dap'.step_into()<CR>", opts)
vim.keymap.set("n", "<F12>", ":lua require'dap'.step_out()<CR>", opts)
vim.keymap.set("n", "<Leader>b", ":lua require'dap'.toggle_breakpoint()<CR>", opts)
vim.keymap.set("n", "<Leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('condition: '))<CR>", opts)
vim.keymap.set("n", "<Leader>lp", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('message: '))<CR>", opts)
vim.keymap.set("n", "<C-x>", ":lua require'dap'.repl.toggle()<CR>", opts)
vim.keymap.set("n", "<Leader>dl", ":lua require'dap'.run_last()<CR>", opts)

local local_rc = os.getenv("LOCAL_RC")
if local_rc ~= nil then
  for _, project_path in ipairs(vim.fn.split(local_rc, ":")) do
    vim.api.nvim_create_autocmd({ "BufReadPost" }, {
      pattern = project_path .. "/**",
      command = vim.cmd("source " .. project_path .. "/.exrc"),
    })
  end
end
