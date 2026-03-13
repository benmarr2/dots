local dap = require("dap")

dap.adapters.coreclr = {
	type = "executable",
	command = "netcoredbg",
	args = { "--interpreter=vscode" },
}

dap.configurations.cs = {
	{
		type = "coreclr",
		name = "Attach to Godot (.NET)",
		request = "attach",
		processId = require("dap.utils").pick_process,
	},
}
