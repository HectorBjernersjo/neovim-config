return {
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("oil").setup({
				columns = { "icon" },
				vim.keymap.set("n", "<leader>pv", "<CMD>Oil<CR>", { desc = "Open directory in oil" }),
				view_options = {
					show_hidden = true,
				},
			})
		end,
	},
}
