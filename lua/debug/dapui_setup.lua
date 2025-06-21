local dap = require('dap')
local dapui = require('dapui')

dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
    dapui.open()
end
dap.listeners.before.event_exited.dapui_config = function()
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
