-- lua/custom/lsp/servers/lua.lua
local util = require("lspconfig.util")
local M = {}

M.enabled = true

M.opts = {
	-- tell sumneko‑lua where your project root is
	root_dir = util.root_pattern(".git", ".luarc.json", ".luacheckrc", "stylua.toml"),

	settings = {
		Lua = {
			runtime = {
				-- LuaJIT in Neovim
				version = "LuaJIT",
				path = vim.split(package.path, ";"),
			},
			diagnostics = {
				-- recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			telemetry = {
				enable = false,
			},
		},
	},
}

return M
