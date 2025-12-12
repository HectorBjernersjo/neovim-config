return {
    {
        "mason-org/mason.nvim",
        config = function()
            require("mason").setup({
                registries = {
                    "github:mason-org/mason-registry",
                    "github:Crashdummyy/mason-registry",
                },
            })
        end,
    },
    {
        "mason-org/mason-lspconfig.nvim",
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
            automatic_enable = true,
        },
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
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "saghen/blink.cmp",
        },
        config = function()
            require("keymaps").lsp()

            -- Using the HEAD syntax as requested
            vim.lsp.enable("lua_ls")
            vim.lsp.enable("ts_ls")
            vim.lsp.enable("html")
            vim.lsp.enable("cssls")
            vim.lsp.enable("bashls")
            -- vim.lsp.enable("pyright")
            vim.lsp.enable("hls")
            vim.lsp.enable("clangd")
            -- vim.lsp.enable("dartls")
            vim.lsp.enable("rust_analyzer")

            require("scripts.format_on_save")
        end,
    },
}
