return {
    {
        "github/copilot.vim",
        config = function()
            require('keymaps').copilot()
            vim.cmd("Copilot disable")
        end
    }
}
