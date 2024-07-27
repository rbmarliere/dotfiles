local dap = require("dap")
dap.set_log_level("TRACE")

dap.adapters.cppdbg = {
	id = "cppdbg",
	type = "executable",
	command = vim.fn.stdpath("data") .. "/mason/bin/OpenDebugAD7",
}

dap.configurations.c = {
	{
		name = "Attach to gdbserver :1234",
		type = "cppdbg",
		request = "launch",
		MIMode = "gdb",
		miDebuggerServerAddress = "localhost:1234",
		miDebuggerPath = "/usr/bin/gdb",
		cwd = "${workspaceFolder}",
		args = { "-ex", "continue" },
		program = "~/src/linux/kernel/vmlinux",
		stopAtEntry = false,
		-- program = function()
		-- 	return vim.fn.input("Path to vmlinux: ", vim.fn.getcwd() .. "/", "file")
		-- end,
	},
}
