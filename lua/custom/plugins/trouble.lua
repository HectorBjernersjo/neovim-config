return {
	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = { "Trouble" },
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics<cr>",
				desc = "All Diagnostics for Current Directory (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp_definitions<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},

		config = function()
			require("trouble").setup({
				modes = {
					my_diagnostics = {
						mode = "diagnostics",
						-- filter = { buf = 0, ft = "lua" },
						filter = function(items)
							local cwd = vim.loop.cwd() -- Get current working directory
							return vim.tbl_filter(function(item)
								-- Filter items based on their file path being in the current directory
								return item.filename:find(cwd, 1, true) ~= nil
							end, items)
						end,
					},
				},
			})
		end,
	},
}
