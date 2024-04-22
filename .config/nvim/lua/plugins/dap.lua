return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"mfussenegger/nvim-dap-python",
		{
			"theHamsta/nvim-dap-virtual-text",
			opts = {
				commented = true,
				virt_text_win_col = 90,
				highlight_changed_variables = true,
			},
		},
		{
			"rcarriga/nvim-dap-ui",
			dependencies = {
				"nvim-neotest/nvim-nio",
			},
			opts = {
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
			},
		},
	},
	config = function()
		local dap = require("dap")
		local widgets = require("dap.ui.widgets")
		local opts = { silent = true }
		vim.keymap.set("n", "<Leader><C-x>", require("dapui").toggle, opts)
		vim.keymap.set("n", "<F8>", require("nvim-dap-virtual-text").toggle, opts)
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
	end,
}
