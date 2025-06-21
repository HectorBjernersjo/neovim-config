vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'dap-repl', 'dapui_watches', 'dapui_hover' },
    callback = function()
        vim.b.completion = true
    end,
    desc = 'Enable completion for DAP-REPL filetypes'
})

return {
    {
        'saghen/blink.compat',
        version = '2.*',
        lazy = true,
        opts = {},
    },
    {
        'saghen/blink.cmp',
        dependencies = {
            'rcarriga/cmp-dap',
            'saghen/blink.compat',
            'L3MON4D3/LuaSnip',
        },
        opts = {
            keymap = { preset = 'default' },

            appearance = {
                nerd_font_variant = 'mono'
            },

            completion = { documentation = { auto_show = false } },
            snippets = { preset = "luasnip" },
            sources = {
                default = { 'snippets', 'lsp', 'path', 'buffer' },

                per_filetype = {
                    sql = { 'snippets', 'dadbod', 'buffer' },
                    ['dap-repl'] = { 'dap', score_offset = 200 },
                    ['dapui_watches'] = { 'dap', score_offset = 200 },
                    ['dapui_hover'] = { 'dap', score_offset = 200 },
                },

                providers = {
                    dadbod = { name = 'Dadbod', module = 'vim_dadbod_completion.blink' },
                    dap = {
                        score_offset = 400,
                        name = 'dap',
                        module = 'blink.compat.source',
                    },
                    path = {
                        score_offset = 300
                    },
                    snippets = {
                        score_offset = 200
                    },
                    lsp = {
                        score_offset = 100
                    },
                    buffer = {
                        score_offset = 0,
                        max_items = 5,
                    }
                },
            },

            fuzzy = { implementation = 'lua' },
            cmdline = {
                keymap = { preset = 'inherit' },
                completion = { menu = { auto_show = true } },
            },
        },
        opts_extend = { 'sources.default' }
    }
}
