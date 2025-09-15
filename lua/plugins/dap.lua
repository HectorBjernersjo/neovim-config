return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            -- "rcarriga/cmp-dap",
            {
                "jay-babu/mason-nvim-dap.nvim",
                -- This config function will now run BEFORE the nvim-dap config
                config = function()
                    require("mason-nvim-dap").setup({
                        ensure_installed = { "cpptools" },
                    })
                end,
            },
        },
        config = function()
            local dap = require('dap');
            local dapui = require('dapui');
            require("mason-nvim-dap").setup({
                ensure_installed = { "cpptools" }
            })

            require('debug.dapui_setup')
            require('debug.python')
            require('debug.dotnet')
            require('debug.c')


            require('keymaps').dap()
        end
    },

}
