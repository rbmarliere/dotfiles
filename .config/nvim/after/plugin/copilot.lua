-- no completions in debugger console
vim.g.copilot_filetypes = { ["dap-repl"] = false }
vim.g.copilot_no_tab_map = true
vim.cmd([[imap <silent><script><expr> <Right> copilot#Accept("\<CR>")]])
