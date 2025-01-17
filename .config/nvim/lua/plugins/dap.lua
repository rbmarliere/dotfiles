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
						position = "top",
						size = 8,
					},
					{
						elements = {
							{
								id = "scopes",
								size = 1,
							},
						},
						position = "top",
						size = 12,
					},
					{
						elements = {
							{
								id = "repl",
								size = 1,
							},
						},
						position = "bottom",
						size = 22,
					},
				},
			},
		},
	},
	config = function()
		local dap = require("dap")
		local dap_utils = require("dap.utils")
		local dapui = require("dapui")
		local virtual_text = require("nvim-dap-virtual-text")
		local widgets = require("dap.ui.widgets")

		-- dap.set_log_level("TRACE")

		vim.keymap.set("n", "<Leader>dxx", dap.close, { silent = true, desc = "DAP Close" })
		vim.keymap.set("n", "<Leader>dxc", dap.continue, { silent = true, desc = "DAP Continue" })
		vim.keymap.set("n", "<Leader>dxi", dap.step_into, { silent = true, desc = "DAP Step Into" })
		vim.keymap.set("n", "<Leader>dxo", dap.step_over, { silent = true, desc = "DAP Step Over" })
		vim.keymap.set("n", "<Leader>dtv", virtual_text.toggle, { silent = true, desc = "DAP Toggle Virtual Text" })
		vim.keymap.set("n", "<Leader>dtu", dapui.toggle, { silent = true, desc = "DAP Toggle UI" })
		vim.keymap.set("n", "<Leader>dbB", function()
			dap.set_breakpoint(vim.fn.input("condition: "))
		end, { silent = true, desc = "DAP Add conditional breakpoint" })
		vim.keymap.set("n", "<Leader>dbb", dap.toggle_breakpoint, { silent = true, desc = "DAP Add breakpoint" })
		vim.keymap.set("n", "<Leader>dbm", function()
			dap.set_breakpoint(nil, nil, vim.fn.input("message: "))
		end, { silent = true, desc = "DAP Add breakpoint with log message" })
		vim.keymap.set("n", "<Leader>drl", function()
			vim.cmd("silent! write")
			dap.run_last()
		end, { silent = true, desc = "DAP Run last" })
		vim.keymap.set("n", "<Leader>dlb", function()
			dap.list_breakpoints()
			vim.cmd.copen()
		end, { silent = true, desc = "DAP List breakpoints" })
		vim.keymap.set("n", "<Leader>dls", function()
			widgets.centered_float(widgets.sessions)
		end, { silent = true, desc = "DAP List sessions" })
		vim.keymap.set("n", "<Leader>dlt", function()
			widgets.centered_float(widgets.threads)
		end, { silent = true, desc = "DAP List threads" })

		dap.adapters.gdb = {
			type = "executable",
			command = "gdb",
			args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
		}

		dap.adapters.cppdbg = {
			id = "cppdbg",
			type = "executable",
			command = vim.fn.stdpath("data") .. "/mason/bin/OpenDebugAD7",
		}

		local gdb = {
			{
				name = "Launch",
				type = "gdb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopAtBeginningOfMainSubprogram = false,
			},
			{
				name = "Select and attach to process",
				type = "gdb",
				request = "attach",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				pid = function()
					local name = vim.fn.input("Executable name (filter): ")
					return dap_utils.pick_process({ filter = name })
				end,
				cwd = "${workspaceFolder}",
			},
			{
				name = "Attach to gdbserver :1234",
				type = "gdb",
				request = "attach",
				target = "localhost:1234",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
			},
		}

		local cppdbg = {
			{
				name = "Launch file",
				type = "cppdbg",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopAtEntry = true,
			},
			{
				name = "Attach to gdbserver :1234",
				type = "cppdbg",
				request = "launch",
				MIMode = "gdb",
				miDebuggerServerAddress = "localhost:1234",
				miDebuggerPath = "/usr/bin/gdb",
				cwd = "${workspaceFolder}",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
			},
		}

		dap.configurations.c = gdb
		-- dap.configurations.c = cppdbg
		dap.configurations.cpp = cppdbg
		dap.configurations.rust = cppdbg
	end,
}
