return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            -- "rcarriga/cmp-dap",
        },
        config = function()
            local dap = require('dap');
            local dapui = require('dapui');

            require('debug.dapui_setup')
            require('debug.python')
            require('debug.dotnet')


            require('keymaps').dap()
        end
    }
}
