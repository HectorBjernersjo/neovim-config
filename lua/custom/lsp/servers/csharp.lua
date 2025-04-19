-- lua/custom/lsp/servers/csharp.lua
local util = require("lspconfig.util")
local M = {}

-- flip this to false if you ever want C# disabled
M.enabled = true

M.opts = {
  -- mason will install "omnisharp" for us,
  -- so we just point to it and pass the --languageserver flag
  cmd = {
    "omnisharp",
    "--languageserver",
    "--hostPID",
    tostring(vim.fn.getpid()),
  },

  -- how we determine the project root
  root_dir = util.root_pattern("*.sln", "*.csproj"),

  -- OmniSharp‑specific settings you can tweak
  enable_editorconfig_support = true,
  enable_roslyn_analyzers     = true,
  organize_imports_on_format  = true,
  enable_import_completion    = true,
}

return M
