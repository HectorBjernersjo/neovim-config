local dap = require('dap')

dap.adapters.python = {
    type = "executable",
    command = "python",
    args = { '-m', 'debugpy.adapter' },
    options = {
        source_filetype = 'python',
    },
}

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
