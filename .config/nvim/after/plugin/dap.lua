require("nvim-dap-virtual-text").setup({
  commented = true,
  virt_text_win_col = 90,
  highlight_changed_variables = true,
})

require("dapui").setup({
  layouts = { {
    elements = { {
      id = "scopes",
      size = 1
    } },
    position = "bottom",
    size = 22
  }, {
    elements = { {
      id = "stacks",
      size = 0.33
    }, {
      id = "breakpoints",
      size = 0.34
    }, {
      id = "watches",
      size = 0.33
    } },
    position = "left",
    size = 65
  }, {
    elements = { {
      id = "repl",
      size = 1
    } },
    position = "right",
    size = 120
  } },
})

local dapui_opened = false

local toggle_ui = function()
  local bufname = vim.fn.bufname()
  if bufname == "" then
    return
  end

  local dap_repl = vim.fn.bufnr("[dap-repl]")
  local repl_win = vim.fn.win_findbuf(dap_repl)[1]
  if repl_win == nil then
    -- if dap repl is not in a window, reset the flag
    dapui_opened = false
  end

  if dapui_opened then
    return
  end

  if vim.fn.tabpagebuflist()[2] == nil then
    require("dapui").open()
    dapui_opened = true
  else
    -- if current tab has more than one buffer, open dap ui in a new tab
    local curpos = vim.fn.getcurpos()
    vim.cmd.tabedit(bufname)
    vim.fn.setpos(".", curpos)

    require("dapui").open()
    dapui_opened = true
  end
end

local run_dap = function()
  vim.cmd([[write]])
  require("dap").continue()
end

local opts = { silent = true }

vim.keymap.set("n", "<C-x>", toggle_ui, opts)
vim.keymap.set("n", "<F8>", ":DapVirtualTextToggle<CR>", opts)
vim.keymap.set("n", "<F10>", ":lua require'dap'.step_over()<CR>", opts)
vim.keymap.set("n", "<F11>", ":lua require'dap'.step_into()<CR>", opts)
vim.keymap.set("n", "<F12>", ":lua require'dap'.step_out()<CR>", opts)
vim.keymap.set("n", "<F4>", ":lua require'dap'.close()<CR>", opts)
vim.keymap.set("n", "<F5>", ":sil! write | lua require'dap'.continue()<CR>", opts)
vim.keymap.set("n", "<Leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('condition: '))<CR>", opts)
vim.keymap.set("n", "<Leader>b", ":lua require'dap'.toggle_breakpoint()<CR>", opts)
vim.keymap.set("n", "<Leader>dl", ":sil! write | lua require'dap'.run_last()<CR>", opts)
vim.keymap.set("n", "<Leader>lb", ":lua require'dap'.list_breakpoints()<CR>:copen<CR>", opts)
vim.keymap.set("n", "<Leader>lp", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('message: '))<CR>", opts)
vim.keymap.set("n", "<Leader>ls", function()
  local widgets = require("dap.ui.widgets")
  widgets.centered_float(widgets.sessions)
end, opts)
vim.keymap.set("n", "<Leader>lt", function()
  local widgets = require("dap.ui.widgets")
  widgets.centered_float(widgets.threads)
end, opts)
