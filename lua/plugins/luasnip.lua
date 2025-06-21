return {
    {
        'L3MON4D3/LuaSnip',
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
            local ls = require('luasnip')
            local s = ls.snippet
            local t = ls.text_node
            local i = ls.insert_node

            require("luasnip.loaders.from_vscode").lazy_load()

            ls.add_snippets("lua", {
                s("hello", {
                    t('print("Hello World")')
                })
            })
        end
    }
}
