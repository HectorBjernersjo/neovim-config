-- lua/custom/lsp/servers/python.lua
local M = {}

M.enabled = true

M.opts = {
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",
        diagnosticMode    = "workspace",
      },
    },
  },
}

return M
