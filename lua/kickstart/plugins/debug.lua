return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"mfussenegger/nvim-dap-python",
			"nvim-neotest/nvim-nio",
			"rcarriga/nvim-dap-ui",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- Python DAP setup
			require("dap-python").setup("python3")

			-- Setting default Python configuration to set working directory and PYTHONPATH
			dap.configurations.python = {
				{
					type = "python",
					request = "launch",
					name = "Launch file",
					program = "${file}", -- Launch the current file
					pythonPath = function()
						return "python3" -- Specify Python interpreter
					end,
					cwd = "${workspaceFolder}", -- Set the working directory to the current workspace folder
					env = function()
						return {
							PYTHONPATH = "${workspaceFolder}", -- Add the current workspace folder to PYTHONPATH
						}
					end,
					console = "integratedTerminal", -- Use the integrated terminal instead of DAP REPL
				},
			}

			-- -- Configure Java debugging
			-- dap.adapters.java = {
			-- 	type = "server",
			-- 	host = "127.0.0.1",
			-- 	port = 5005, -- Default debug server port
			-- }
			--
			-- dap.configurations.java = {
			-- 	{
			-- 		type = "java",
			-- 		request = "attach",
			-- 		name = "Attach to running JVM",
			-- 		hostName = "127.0.0.1",
			-- 		port = 5005,
			-- 	},
			-- 	{
			-- 		type = "java",
			-- 		request = "launch",
			-- 		name = "Launch Java Application",
			-- 		mainClass = "<Path_to_Main_Class>", -- Replace with the main class path
			-- 		projectRoot = vim.fn.getcwd(), -- Sets the current working directory as project root
			-- 		args = {}, -- Add arguments to pass to the application
			-- 		jvmArgs = {}, -- Add JVM arguments if needed
			-- 		env = { JAVA_HOME = "/path/to/your/java/home" },
			-- 	},
			-- }

			-- Optional: Configure custom DAP key mappings
			vim.keymap.set("n", "<F4>", dapui.toggle, { desc = "Debug: Toggle UI" })
			vim.keymap.set("n", "<F5>", function()
				dap.continue()
			end)
			vim.keymap.set("n", "<F6>", dap.run_to_cursor, { desc = "Debug: Run to cursor" })
			vim.keymap.set("n", "<leader>d", function()
				dap.continue()
			end)
			vim.keymap.set("n", "<leader>n", function()
				dap.step_over()
			end)
			vim.keymap.set("n", "<F11>", function()
				dap.step_into()
			end)
			vim.keymap.set("n", "<leader>i", function()
				dap.step_into()
			end)
			vim.keymap.set("n", "<F12>", function()
				dap.step_out()
			end)
			vim.keymap.set("n", "<Leader>b", function()
				dap.toggle_breakpoint()
			end)
			vim.keymap.set("n", "<Leader>B", function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end)

			-- DAP UI setup
			local dapui = require("dapui")
			dapui.setup()

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end

			dapui.setup({
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
							"watches",
							{ id = "repl", size = 0.5 }, -- REPL and Watches on the right
						},
						size = 60,
						position = "right",
					},
					{
						elements = {
							{ id = "console", size = 1.0 }, -- Console taking up the full bottom space
						},
						size = 15, -- Adjust this as needed for console height
						position = "bottom",
					},
				},
			})
		end,
	},
}
