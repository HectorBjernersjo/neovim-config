return {
	"mfussenegger/nvim-dap",
	event = "VeryLazy",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"theHamsta/nvim-dap-virtual-text",
		"mfussenegger/nvim-dap-python",
	},

	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		local dap_python = require("dap-python")

		require("nvim-dap-virtual-text").setup({})

		-- Basic debugging keymaps, feel free to change to your liking!
		vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
		vim.keymap.set("n", "<F4>", dapui.toggle, { desc = "Debug: Toggle UI" })
		vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
		vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
		-- vim.keymap.set('n', '<F12>', dap.step_out, { desc = 'Debug: Step Out' })
		vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
		vim.keymap.set("n", "<leader>B", function()
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end, { desc = "Debug: Set Breakpoint" })

		-- Dap UI setup
		-- For more information, see |:help nvim-dap-ui|
		dapui.setup({
			-- Set icons to characters that are more likely to work in every terminal.
			--    Feel free to remove or use ones that you like more! :)
			--    Don't feel like these are good choices.
			icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
			controls = {
				icons = {
					pause = "⏸",
					play = "▶",
					step_into = "⏎",
					step_over = "⏭",
					step_out = "⏮",
					step_back = "b",
					run_last = "▶▶",
					terminate = "⏹",
					disconnect = "⏏",
				},
			},
			layouts = {
				{
					elements = {
						"scopes",
						-- 'stacks',
						"watches",
						"repl",
						-- Exclude breakpoints and [dap-repl] by not listing them here
					},
					size = 40, -- Adjust size as needed
					position = "right", -- Can be "left", "right", "top", "bottom"
				},
				{
					elements = {
						"console", -- Include the integrated terminal
					},
					size = 10, -- Adjust size for the terminal as needed
					position = "bottom", -- Position of the terminal
				},
			},
		})

		-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
		vim.keymap.set("n", "<F7>", dapui.toggle, { desc = "Debug: See last session result." })

		dap.listeners.after.event_initialized["dapui_config"] = dapui.open
		-- dap.listeners.before.event_terminated['dapui_config'] = dapui.close
		-- dap.listeners.before.event_exited['dapui_config'] = dapui.close

		dap_python.setup("python3")
		dap_python.test_runner = "pytest"
	end,
}
