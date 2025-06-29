return {
    {
        'ellisonleao/gruvbox.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme 'gruvbox'
        end,
    },
    -- {
    --     'rebelot/kanagawa.nvim',
    --     lazy = false,
    --     priority = 1000,
    --     config = function()
    --         vim.cmd.colorscheme 'kanagawa'
    --     end,
    -- },
    -- { 'folke/tokyonight.nvim' },
    -- { 'sainnhe/gruvbox-material' },
    -- { 'luisiacc/gruvbox-baby' },
    -- { 'rose-pine/neovim', name = 'rose-pine' },
}
