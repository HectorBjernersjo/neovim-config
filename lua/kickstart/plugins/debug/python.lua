-- ~/.config/nvim/lua/debug/python.lua
local dap = require("dap")

return function()
	-- dap-python plugin itself will be a separate plugin spec
	require("dap-python").setup("python3")

	dap.configurations.python = {
		{
			type = "python",
			request = "launch",
			name = "Launch file",
			program = "${file}",
			pythonPath = function()
				return "python3"
			end,
			cwd = "${workspaceFolder}",
			env = function()
				return { PYTHONPATH = "${workspaceFolder}" }
			end,
			console = "integratedTerminal",
		},
	}
end
