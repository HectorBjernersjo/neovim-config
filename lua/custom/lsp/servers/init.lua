-- lua/custom/lsp/servers/init.lua
return {
    pyright   = require("custom.lsp.servers.python"),
    omnisharp = require("custom.lsp.servers.csharp"),
    lua_ls    = require("custom.lsp.servers.lua"),

    ts_ls     = require("custom.lsp.servers.ts_ls"),
    html      = require("custom.lsp.servers.html"),
    cssls     = require("custom.lsp.servers.cssls"),
}
