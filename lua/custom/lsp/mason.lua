-- lua/custom/lsp/mason.lua
local M = {}

function M.setup()
	local servers = require("custom.lsp.servers")
	-- collect the names of all enabled servers
	local ensure = {}
	for name, cfg in pairs(servers) do
		if cfg.enabled then
			table.insert(ensure, name)
		end
	end

	require("mason").setup()
	require("mason-lspconfig").setup({
		ensure_installed = ensure,
	})
end

return M
