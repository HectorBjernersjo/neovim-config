-- lua/custom/lsp/handlers.lua
local M = {}

-- configure diagnostics (signs, virtual_text, underline, etc)
vim.diagnostic.config({
	signs = {
		severity = {
			[vim.diagnostic.severity.ERROR] = { text = "", texthl = "DiagnosticError" },
			[vim.diagnostic.severity.WARN] = { text = "", texthl = "DiagnosticWarn" },
			[vim.diagnostic.severity.INFO] = { text = "", texthl = "DiagnosticInfo" },
			[vim.diagnostic.severity.HINT] = { text = "", texthl = "DiagnosticHint" },
		},
	},
	virtual_text = true,
	underline = true,
	update_in_insert = false,
})

-- link the virtual-text highlight groups
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { link = "DiagnosticError" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { link = "DiagnosticWarn" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { link = "DiagnosticInfo" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { link = "DiagnosticHint" })

M.on_attach = function(client, bufnr)
	-- enable omnifunc
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	local opts = { noremap = true, silent = true, buffer = bufnr }
	local km = vim.keymap.set

	km("n", "gd", vim.lsp.buf.definition, opts)
	km("n", "gD", vim.lsp.buf.declaration, opts)
	km("n", "gr", vim.lsp.buf.references, opts)
	km("n", "gi", vim.lsp.buf.implementation, opts)
	km("n", "K", vim.lsp.buf.hover, opts)
	km("n", "<leader>rn", vim.lsp.buf.rename, opts)
	km("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	km("n", "[d", vim.diagnostic.goto_prev, opts)
	km("n", "]d", vim.diagnostic.goto_next, opts)
	km("n", "<leader>q", vim.diagnostic.setloclist, opts)
end

return M
