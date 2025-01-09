return {
	{
		"dccsillag/magma-nvim",
		run = ":UpdateRemotePlugins",
		config = function()
			-- Keybindings
			vim.api.nvim_set_keymap(
				"n",
				"<LocalLeader>r",
				":MagmaEvaluateOperator<CR>",
				{ noremap = true, silent = true, expr = true }
			)
			vim.api.nvim_set_keymap("n", "<LocalLeader>rr", ":MagmaEvaluateLine<CR>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap(
				"x",
				"<LocalLeader>r",
				":<C-u>MagmaEvaluateVisual<CR>",
				{ noremap = true, silent = true }
			)
			vim.api.nvim_set_keymap(
				"n",
				"<LocalLeader>rc",
				":MagmaReevaluateCell<CR>",
				{ noremap = true, silent = true }
			)
			vim.api.nvim_set_keymap("n", "<LocalLeader>rd", ":MagmaDelete<CR>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("n", "<LocalLeader>ro", ":MagmaShowOutput<CR>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap(
				"n",
				"<LocalLeader>rq",
				":noautocmd MagmaEnterOutput<CR>",
				{ noremap = true, silent = true }
			)

			-- Suggested options
			vim.g.magma_automatically_open_output = false
			vim.g.magma_image_provider = "ueberzug"
			vim.g.magma_wrap_output = true
			vim.g.magma_output_window_borders = true
			vim.g.magma_cell_highlight_group = "CursorLine"
		end,
	},
}
