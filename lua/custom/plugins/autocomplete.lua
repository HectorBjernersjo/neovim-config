return {
	{ -- Autocompletion
		"hrsh7th/nvim-cmp",
		event = "VimEnter",
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			{
				"rcarriga/cmp-dap",
				"L3MON4D3/LuaSnip",
			},
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets", -- Collection of snippets including HTML
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-buffer",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			luasnip.config.setup({})

			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				completion = { completeopt = "menu,menuone,noinsert" },

				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete({}),
				}),

				sources = {
					{ name = "nvim_lsp" },
					{ name = "otter" },
					{ name = "luasnip" },
					{ name = "path" },
					{ name = "buffer" },
					{ name = "dap" },
				},
			})

			-- `/` cmdline setup.
			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})
			-- `:` cmdline setup.
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{
						name = "cmdline",
						option = {
							ignore_cmds = { "Man", "!" },
						},
					},
				}),
			})

			require("cmp").setup({
				enabled = function()
					return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" or require("cmp_dap").is_dap_buffer()
				end,
			})

			require("cmp").setup.filetype({ "cs", "dap-repl", "dapui_watches", "dapui_hover" }, {
				sources = {
					{ name = "dap" },
					{ name = "nvim_lsp" },
					{ name = "path" },
					{ name = "buffer" },
				},
			})
			vim.api.nvim_create_autocmd("BufEnter", {
				pattern = { "*" },
				callback = function()
					local buftype = vim.api.nvim_buf_get_option(0, "buftype")
					local filetype = vim.api.nvim_buf_get_option(0, "filetype")
					print("Buffer type: " .. buftype .. ", Filetype: " .. filetype)
				end,
			})
		end,
	},
}
