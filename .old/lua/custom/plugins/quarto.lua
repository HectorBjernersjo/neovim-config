return {
	{
		"quarto-dev/quarto-nvim",
		opts = {},
		dependencies = {
			"jmbuhr/otter.nvim",
			opts = {},
		},
		config = function()
			vim.keymap.set({ "n", "i" }, "<m-i>", "<esc>i```{python}<cr>```<esc>O", { desc = "[i]nsert code chunk" })
		end,
	},
}
