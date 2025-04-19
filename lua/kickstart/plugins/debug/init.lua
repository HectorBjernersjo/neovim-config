return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			{
				"mfussenegger/nvim-dap-python",
				config = function()
					require("kickstart.plugins.debug.python")()
				end,
			},
			{ "nvim-neotest/nvim-nio" },
			{
				"rcarriga/nvim-dap-ui",
				config = function()
					require("kickstart.plugins.debug.ui")()
				end,
			},
		},
		config = function()
			require("kickstart.plugins.debug.keymaps")()
			require("kickstart.plugins.debug.csharp")()
		end,
	},
}
