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
    --
    -- how we determine the project root
    root_dir = util.root_pattern("*.sln", "*.csproj"),
    settings = {
        -- respect your .editorconfig
        EnableEditorConfigSupport = true,
        -- run Roslyn analyzers in the background
        EnableRoslynAnalyzers = true,

        -- turn on “show me types I haven’t imported yet”
        RoslynExtensionsOptions = {
            EnableImportCompletion = true,
        },

        -- when formatting, keep usings tidy
        FormattingOptions = {
            OrganizeImports = true,
        },
    },
}

return M
