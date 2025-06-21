-- ~/.config/nvim/init.lua

-- 1. Define a function for common LSP keymappings (optional, but highly recommended)
-- This function will be called once the language server attaches to a buffer.
local function on_attach(client, bufnr)
    print("LSP attached: " .. client.name)

    local opts = { noremap = true, silent = true, buffer = bufnr }
    local keymap = vim.keymap.set

    -- Keymaps for common LSP actions
    keymap('n', 'gD', vim.lsp.buf.declaration, opts)
    keymap('n', 'gd', vim.lsp.buf.definition, opts)
    keymap('n', 'K', vim.lsp.buf.hover, opts)
    keymap('n', 'gi', vim.lsp.buf.implementation, opts)
    keymap('n', '<space>rn', vim.lsp.buf.rename, opts)
    keymap('n', '<space>ca', vim.lsp.buf.code_action, opts)
    keymap('n', 'gr', vim.lsp.buf.references, opts)

    -- Keymaps for diagnostics
    keymap('n', '<space>e', vim.diagnostic.open_float, opts)
    keymap('n', '[d', vim.diagnostic.goto_prev, opts)
    keymap('n', ']d', vim.diagnostic.goto_next, opts)

    -- Optional: Enable formatting on save if the server supports it
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("LspFormatOnSave", { clear = true }),
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
            end,
        })
    end
end

-- 2. Define the command to start your custom-built language server
local cmd = {
    "dotnet",
    -- The path to your language server DLL
    "/home/hector/roslyn/artifacts/bin/Microsoft.CodeAnalysis.LanguageServer/Debug/net9.0/Microsoft.CodeAnalysis.LanguageServer.dll",
    -- Server arguments
    "--stdio",
    "--logLevel=Information",
    "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
    -- Arguments for Razor integration.
    -- Note: The single quotes are removed as they are not needed when passing arguments directly.
    "--razorSourceGenerator=/home/hector/razor/artifacts/bin/Microsoft.AspNetCore.Razor.LanguageServer/Debug/net9.0/Microsoft.CodeAnalysis.Razor.Compiler.dll",
    "--razorDesignTimePath=/home/hector/razor/src/Razor/src/rzls/Targets/Microsoft.NET.Sdk.Razor.DesignTime.targets",
}

-- 3. Create an autocommand to start the LSP when you open a relevant file
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'cs', 'razor', 'cshtml' }, -- Filetypes that will trigger this LSP
    callback = function(args)
        -- Find the project root directory (containing .sln or .csproj file)
        local root_dir = vim.fs.dirname(vim.fs.find({ '.sln', '*.csproj' }, { upward = true, path = args.file })[1] or
            vim.fn.getcwd())

        if not root_dir then
            print("Could not find project root for LSP.")
            return
        end

        -- Start the LSP client
        vim.lsp.start({
            name = 'custom-roslyn-razor', -- A unique name for your server configuration
            cmd = cmd,
            root_dir = root_dir,
            on_attach = on_attach, -- Attach the keymappings
        })
    end,
})
