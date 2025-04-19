-- lua/custom/lsp/plugins.lua
return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            require("custom.lsp.mason").setup()
            require("custom.lsp").setup()
        end,
    },
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup()
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
            "rcarriga/cmp-dap", -- ← DAP source
            "hrsh7th/cmp-buffer", -- ← buffer source (if not already installed)
            "hrsh7th/cmp-path", -- ← path source
            "hrsh7th/cmp-cmdline", -- ← cmdline source
        },
        config = function()
            require("custom.lsp.cmp").setup()
        end,
    },
    {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
    },
}
