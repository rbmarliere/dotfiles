local opts = { silent = true }
local dap = require("dap")
local dapui = require("dapui")
local vtext = require("nvim-dap-virtual-text")
local widgets = require("dap.ui.widgets")

vtext.setup({
	commented = true,
	virt_text_win_col = 90,
	highlight_changed_variables = true,
})

dapui.setup({
	layouts = {
		{
			elements = { {
				id = "scopes",
				size = 1,
			} },
			position = "bottom",
			size = 22,
		},
		{
			elements = {
				{
					id = "stacks",
					size = 0.33,
				},
				{
					id = "breakpoints",
					size = 0.34,
				},
				{
					id = "watches",
					size = 0.33,
				},
			},
			position = "left",
			size = 65,
		},
		{
			elements = { {
				id = "repl",
				size = 1,
			} },
			position = "right",
			size = 120,
		},
	},
})

vim.keymap.set("n", "<Leader><C-x>", dapui.toggle, opts)
vim.keymap.set("n", "<F8>", vtext.toggle, opts)
vim.keymap.set("n", "<F10>", dap.step_over, opts)
vim.keymap.set("n", "<F11>", dap.step_into, opts)
vim.keymap.set("n", "<F12>", dap.step_over, opts)
vim.keymap.set("n", "<F4>", dap.close, opts)
vim.keymap.set("n", "<F5>", dap.continue, opts)
vim.keymap.set("n", "<Leader>B", function()
	dap.set_breakpoint(vim.fn.input("condition: "))
end, opts)
vim.keymap.set("n", "<Leader>b", dap.toggle_breakpoint, opts)
vim.keymap.set("n", "<Leader>dl", function()
	vim.cmd("silent! write")
	dap.run_last()
end, opts)
vim.keymap.set("n", "<Leader>lb", function()
	dap.list_breakpoints()
	vim.cmd.copen()
end, opts)
vim.keymap.set("n", "<Leader>lp", function()
	dap.set_breakpoint(nil, nil, vim.fn.input("message: "))
end, opts)
vim.keymap.set("n", "<Leader>ls", function()
	widgets.centered_float(widgets.sessions)
end, opts)
vim.keymap.set("n", "<Leader>lt", function()
	widgets.centered_float(widgets.threads)
end, opts)
