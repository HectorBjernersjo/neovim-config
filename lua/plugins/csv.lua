return {
    {
        "hat0uma/csvview.nvim",
        cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
        ft = { "csv", "tsv" },
        opts = {
            view = {
                display_mode = "border",
            },
        },
        config = function(_, opts)
            require("csvview").setup(opts)
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "csv", "tsv" },
                callback = function()
                    require("csvview").enable()
                end,
            })
            require("csvview").enable()
        end,
    },
}
