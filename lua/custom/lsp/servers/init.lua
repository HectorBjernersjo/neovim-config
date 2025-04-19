-- lua/custom/lsp/servers/init.lua
return {
  -- key must match the LSP name that mason-lspconfig & lspconfig expect
  pyright = require("custom.lsp.servers.python"),
  omnisharp  = require("custom.lsp.servers.csharp"),
  lua_ls  = require("custom.lsp.servers.lua"),
}
