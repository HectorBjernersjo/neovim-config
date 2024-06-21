return {
	{ "catppuccin/nvim", event = "VeryLazy" },
	{ "sainnhe/gruvbox-material", event = "VeryLazy" },
	{ "rebelot/kanagawa.nvim", event = "VeryLazy" },
	{ "rose-pine/neovim", event = "VeryLazy" },
	{
		"folke/tokyonight.nvim",
		priority = 1000, -- Make sure to load this before all the other start plugins.
		init = function()
			vim.cmd.colorscheme("tokyonight-night")
			vim.cmd.hi("Comment gui=none")
		end,
	},
}
