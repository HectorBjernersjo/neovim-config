local lsp_zero = require('lsp-zero')

-- Custom function to attach to each LSP client
local function on_attach(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  -- Your custom keybindings
  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<F2>", function() vim.lsp.buf.rename() end, opts)
  -- More keybindings...

  -- Add any additional lsp-zero default keymaps if needed
  lsp_zero.default_keymaps(opts)

  -- Auto-formatting setup
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("LspFormatting", {}),
      buffer = bufnr,
      callback = function()
        -- Use vim.lsp.buf.format() for Neovim 0.8+ or vim.lsp.buf.formatting_sync() for earlier versions    
        vim.lsp.buf.format({ async = true })
      end,
    })
  end
end

-- Set up Mason for managing language servers
require('mason').setup({})

-- Mason-LSPconfig setup
require('mason-lspconfig').setup({
  ensure_installed = {'tsserver', 'rust_analyzer', 'pyright', 'html'},
  handlers = {
    lsp_zero.default_setup,
  },
})

-- Additional server-specific setup
local lspconfig = require('lspconfig')

-- Lua language server setup
lspconfig.lua_ls.setup({
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }, -- Recognize the `vim` global
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true), -- Make the server aware of Neovim runtime files
      },
    },
  },
})

-- HTML language server setup
lspconfig.html.setup({
  on_attach = on_attach,
  -- Add any other server-specific settings here
})

-- Setup for other language servers
-- For example: lspconfig.tsserver.setup{ on_attach = on_attach }
-- Repeat for other languages like rust_analyzer, pyright, etc.


