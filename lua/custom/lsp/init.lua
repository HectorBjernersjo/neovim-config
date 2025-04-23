-- lua/custom/lsp/init.lua
local M = {}

function M.setup()
	local lspconfig = require("lspconfig")
	local cmp_nvim_lsp = require("cmp_nvim_lsp")
	local handlers = require("custom.lsp.handlers")
	local servers = require("custom.lsp.servers")

	-- augment capabilities for nvim-cmp
	local capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

	for name, srv in pairs(servers) do
		if srv.enabled then
			lspconfig[name].setup(vim.tbl_deep_extend("force", {
				on_attach = handlers.on_attach,
				capabilities = capabilities,
			}, srv.opts or {}))
		end
	end
end

return M
