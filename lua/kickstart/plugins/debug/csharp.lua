-- ~/.config/nvim/lua/debug/csharp.lua
return function()
	local dap = require("dap")

	dap.adapters.coreclr = {
		type = "executable",
		command = "netcoredbg",
		args = { "--interpreter=vscode" },
	}

	dap.configurations.cs = {
		{
			type = "coreclr",
			name = "Launch - netcoredbg",
			request = "launch",
			program = function()
				local cwd = vim.fn.getcwd()
				-- Find the .csproj file in the current directory
				local csproj_file = vim.fn.globpath(cwd, "*.csproj")
				if csproj_file == "" then
					error("Could not find a .csproj file in the current directory: " .. cwd)
				end
				-- Extract the project name from the .csproj file
				local project_name = vim.fn.fnamemodify(csproj_file, ":t:r")
				-- Construct the DLL path
				local dll_path = cwd .. "/bin/Debug/net9.0/" .. project_name .. ".dll"
				-- Ensure the DLL path exists and return it
				if vim.fn.filereadable(dll_path) == 1 then
					return dll_path
				else
					error("Could not find the DLL: " .. dll_path)
				end
			end,
			preLaunchTask = function()
				-- Run dotnet build before starting the debugger
				vim.fn.system("dotnet build --configuration Debug")
			end,
			cwd = "${workspaceFolder}",
			stopAtEntry = false,
			-- console = "integratedTerminal",
		},
	}
end
