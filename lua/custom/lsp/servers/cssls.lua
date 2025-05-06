local util = require("lspconfig.util")
local M = {}

M.enabled = true -- flip to false any time

M.opts = {
    -- Mason installs the ‟vscode‑css‑language‑server” binary for us
    cmd = { "vscode-css-language-server", "--stdio" },

    -- treat any project with package.json or a .git folder as the root
    root_dir = util.root_pattern("package.json", ".git"),

    -- basic validation for the main CSS dialects
    settings = {
        css  = { validate = true },
        scss = { validate = true },
        less = { validate = true },
    },
}

return M
