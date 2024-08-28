return {
	{
		-- "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
		{ "numToStr/Comment.nvim", opts = {} },
		{
			"folke/todo-comments.nvim",
			event = "VimEnter",
			dependencies = { "nvim-lua/plenary.nvim" },
			opts = { signs = false },
		},
		{
			"folke/flash.nvim",
			event = "VeryLazy",
			---@type Flash.Config
			opts = {},
		  -- stylua: ignore
		  keys = {
			{ "m", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
			{ "M", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
			{ "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
			{ "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
			{ "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
		  },
		},
	},
}
