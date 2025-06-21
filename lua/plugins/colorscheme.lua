return {
    {
        'rebelot/kanagawa.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme 'kanagawa'
        end,
    },

    { 'folke/tokyonight.nvim' },
    { 'sainnhe/gruvbox-material' },
    { 'luisiacc/gruvbox-baby' },
    { 'ellisonleao/gruvbox.nvim' },
    { 'rose-pine/neovim',        name = 'rose-pine' },
}
