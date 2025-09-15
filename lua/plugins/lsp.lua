return {
    {
        'mason-org/mason.nvim',
        config = function()
            require("mason").setup({
                registries = {
                    "github:mason-org/mason-registry",
                    "github:Crashdummyy/mason-registry",
                },
            })
        end
    },
    {
        'mason-org/mason-lspconfig.nvim',
        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        opts = {
            ensure_installed = {
                "lua_ls",
                "ts_ls",
                "html",
                "cssls",
                "pyright",
                "bashls",
                "clangd",
            },
            automatic_enable = true
        }
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = { "mason-org/mason.nvim" },
        opts = {
            ensure_installed = {
                "roslyn",
            },
        },
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "saghen/blink.cmp"
        },
        config = function()
            local lspconfig = require('lspconfig')

            require('keymaps').lsp()
            lspconfig.lua_ls.setup({})
            lspconfig.ts_ls.setup({})
            lspconfig.html.setup({})
            lspconfig.cssls.setup({})
            lspconfig.bashls.setup({})
            lspconfig.pyright.setup({})
            lspconfig.hls.setup({})
            lspconfig.clangd.setup({})
            lspconfig.dartls.setup({}) -- Added for Flutter/Dart support

            require('scripts.format_on_save')
        end
    }
}
