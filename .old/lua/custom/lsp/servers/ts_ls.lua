local util = require("lspconfig.util")
local M = {}

M.enabled = true -- flip this to false any time
M.opts = {
    cmd = { "typescript-language-server", "--stdio" },
    init_options = { hostInfo = "neovim" },
    root_dir = util.root_pattern("tsconfig.json", "jsconfig.json", "package.json", ".git"),
}

vim.keymap.set({ 'n', 'v' }, '<leader>ai',
    function()
        vim.lsp.buf.code_action {
            context = { only = { 'source.addMissingImports.ts' } }
        }
    end,
    { desc = 'TS: Add missing imports' })

return M
