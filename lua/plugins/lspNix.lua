return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            "saghen/blink.cmp"
        },
        config = function()
            local lspconfig = require('lspconfig')

            require('keymaps').lsp()
            lspconfig.lua_ls.setup({})
            lspconfig.hls.setup({})
            lspconfig.rust_analyzer.setup({})
            lspconfig.ts_ls.setup({})
            lspconfig.nil_ls.setup({})
            -- require('scripts.format_on_save')
        end
    }
}
