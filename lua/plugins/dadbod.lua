return {
    { "tpope/vim-dadbod" },
    { "kristijanhusak/vim-dadbod-completion" },
    {
        "kristijanhusak/vim-dadbod-ui",
        dependencies = {
            "tpope/vim-dadbod",
        },
        config = function()
            require('keymaps').dadbod()
            vim.g.dadbod_database_type_map = {
                mssql = {
                    -- This is the critical part to modify
                    runner = {
                        args = {
                            'sqlcmd',
                            '-S', '$host',
                            '-d', '$database',
                            '-U', '$user',
                            '-P', '$password',
                            '-s,',    -- Use comma as separator (often better for parsing)
                            '-W',     -- Remove trailing spaces (important for wide columns)
                            '-w 100', -- Set max column width to 100 characters. Adjust this value!
                            -- Or use -w with a very high number and rely on -W to trim.
                            -- '-w 32767', -- Maximum possible width in some versions, combine with -W
                            -- '-h -1', -- No headers. (optional, if you want only data)
                            '-y 0', -- Don't truncate large variables.
                        }
                    }
                }
            }
        end,
    },
}
