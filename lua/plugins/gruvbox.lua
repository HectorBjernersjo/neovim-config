return {
    {
        "sainnhe/gruvbox-material",
        'luisiacc/gruvbox-baby',
        'ellisonleao/gruvbox.nvim',
        config = function()
            vim.cmd [[colorscheme gruvbox]]

            vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#20303b" })
            vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#37222c" })
            vim.api.nvim_set_hl(0, "DiffChange", { bg = "#1f2231" })
            vim.api.nvim_set_hl(0, "DiffText", { bg = "#394b70" })

            vim.api.nvim_set_hl(0, "DiagnosticError", { fg = "#ea6962" }) -- Red
            vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = "#d8a657" })  -- Yellow
            vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = "#7daea3" })  -- Blue
            vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = "#89b482" })  -- Green
        end
    },
}
