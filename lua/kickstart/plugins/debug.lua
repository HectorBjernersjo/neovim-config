local js_based_languages = {
	"typescript",
	"javascript",
}

return {
	"mfussenegger/nvim-dap",
	event = "VeryLazy",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"theHamsta/nvim-dap-virtual-text",
		"mfussenegger/nvim-dap-python",
		"simrat39/rust-tools.nvim",
		{
			"microsoft/vscode-js-debug",
			-- After install, build it and rename the dist directory to out
			build = "npm install --legacy-peer-deps --no-save && npx gulp vsDebugServerBundle && rm -rf out && mv dist out",
			version = "1.*",
		},
		{
			"mxsdev/nvim-dap-vscode-js",
			config = function()
				---@diagnostic disable-next-line: missing-fields
				require("dap-vscode-js").setup({
					-- Path of node executable. Defaults to $NODE_PATH, and then "node"
					-- node_path = "node",

					-- Path to vscode-js-debug installation.
					debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"),

					-- Command to use to launch the debug server. Takes precedence over "node_path" and "debugger_path"
					-- debugger_cmd = { "js-debug-adapter" },

					-- which adapters to register in nvim-dap
					adapters = {
						"chrome",
						"pwa-node",
						"pwa-chrome",
						"pwa-msedge",
						"pwa-extensionHost",
						"node-terminal",
						"node",
					},

					-- Path for file logging
					-- log_file_path = "(stdpath cache)/dap_vscode_js.log",

					-- Logging level for output to file. Set to false to disable logging.
					-- log_file_level = false,

					-- Logging level for output to console. Set to false to disable console output.
					-- log_console_level = vim.log.levels.ERROR,
				})
			end,
		},
		{
			"Joakker/lua-json5",
			build = "./install.sh",
		},
	},

	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		local dap_python = require("dap-python")
		local rust_tools = require("rust-tools")

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

		-- Setup codelldb adapter
		local mason_registry = require("mason-registry")
		local codelldb_root = mason_registry.get_package("codelldb"):get_install_path()
		local codelldb_path = codelldb_root .. "/extension/adapter/codelldb"
		local liblldb_path = codelldb_root .. "/extension/lldb/lib/liblldb"
		local this_os = vim.loop.os_uname().sysname
		liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")

		dap.adapters.codelldb = {
			type = "server",
			port = "${port}",
			executable = {
				command = codelldb_path,
				args = { "--port", "${port}" },
			},
		}

		local function get_rust_executable()
			local cargo_toml = vim.fn.findfile("Cargo.toml", vim.fn.getcwd() .. ";")
			if cargo_toml == "" then
				print("No Cargo.toml found. Are you in a Rust project?")
				return nil
			end

			local cargo_dir = vim.fn.fnamemodify(cargo_toml, ":h")
			local package_name =
				vim.fn.system(string.format("awk -F '\"' '/^name/ {print $2}' %s", cargo_toml)):gsub("%s+", "")

			local debug_executable = string.format("%s/target/debug/%s", cargo_dir, package_name)
			if vim.fn.executable(debug_executable) == 1 then
				return debug_executable
			else
				print("Debug executable not found. Did you run 'cargo build'?")
				return nil
			end
		end
		-- In your config function
		local mason = require("mason")
		mason.setup()

		-- Ensure codelldb is installed
		if not require("mason-registry").is_installed("codelldb") then
			vim.cmd("MasonInstall codelldb")
		end
		-- Rust setup
		rust_tools.setup({
			dap = {
				adapter = dap.adapters.codelldb,
			},
		})

		dap.configurations.rust = {
			{
				name = "Launch Rust Program",
				type = "codelldb", -- This should match the adapter name
				request = "launch",
				program = function()
					return get_rust_executable() or vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				args = {},
				runInTerminal = false,
			},
		}
		-- C# Setup
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
					local dll_path = cwd .. "/bin/Debug/net8.0/" .. vim.fn.fnamemodify(cwd, ":t") .. ".dll"
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
				console = "integratedTerminal",
			},
		}
		for _, language in ipairs(js_based_languages) do
			dap.configurations[language] = {
				-- Debug single nodejs files
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					cwd = vim.fn.getcwd(),
					sourceMaps = true,
				},
				-- Debug nodejs processes (make sure to add --inspect when you run the process)
				{
					type = "pwa-node",
					request = "attach",
					name = "Attach",
					processId = require("dap.utils").pick_process,
					cwd = vim.fn.getcwd(),
					sourceMaps = true,
				},
				-- Debug web applications (client side)
				{
					type = "pwa-chrome",
					request = "launch",
					name = "Launch & Debug Chrome",
					url = function()
						local co = coroutine.running()
						return coroutine.create(function()
							vim.ui.input({
								prompt = "Enter URL: ",
								default = "http://localhost:3000",
							}, function(url)
								if url == nil or url == "" then
									return
								else
									coroutine.resume(co, url)
								end
							end)
						end)
					end,
					webRoot = vim.fn.getcwd(),
					protocol = "inspector",
					sourceMaps = true,
					userDataDir = false,
				},
				-- Divider for the launch.json derived configs
				{
					name = "----- ↓ launch.json configs ↓ -----",
					type = "",
					request = "launch",
				},
			}
		end
	end,
	keys = {
		{
			"<leader>dO",
			function()
				require("dap").step_out()
			end,
			desc = "Step Out",
		},
		{
			"<leader>do",
			function()
				require("dap").step_over()
			end,
			desc = "Step Over",
		},
		{
			"<leader>da",
			function()
				if vim.fn.filereadable(".vscode/launch.json") then
					local dap_vscode = require("dap.ext.vscode")
					dap_vscode.load_launchjs(nil, {
						["pwa-node"] = js_based_languages,
						["node"] = js_based_languages,
						["chrome"] = js_based_languages,
						["pwa-chrome"] = js_based_languages,
					})
				end
				require("dap").continue()
			end,
			desc = "Run with Args",
		},
	},
}
