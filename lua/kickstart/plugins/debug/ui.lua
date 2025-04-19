local dap = require("dap")
local dapui = require("dapui")

return function()
	-- Setup dap-ui itself
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
					{ id = "repl", size = 0.5 },
				},
				size = 60,
				position = "right",
			},
			{
				elements = {
					{ id = "console", size = 1.0 },
				},
				size = 15,
				position = "bottom",
			},
		},
	})

	-- Auto‑open UI when debugging starts
	dap.listeners.after.event_initialized["dapui_config"] = dapui.open
end
