return {
	{ "catppuccin/nvim", event = "VeryLazy" },
	{ "sainnhe/gruvbox-material", event = "VeryLazy" },
	{ "rebelot/kanagawa.nvim", event = "VeryLazy" },
	{ "rose-pine/neovim", event = "VeryLazy" },
	{
		"maxmx03/solarized.nvim",
		event = "VeryLazy",
		config = function()
			vim.o.background = "dark" -- or 'light'
			-- vim.cmd.colorscheme("solarized")
		end,
	},
	{
		"folke/tokyonight.nvim",
		priority = 1000, -- Make sure to load this before all the other start plugins.
		init = function()
			-- Set default colorscheme
			local colorscheme = "tokyonight-night"

			-- Path to the colorscheme file
			local colorscheme_file = vim.fn.stdpath("config") .. "/colorscheme.txt"

			-- Check if the file exists and read the colorscheme from it
			if vim.fn.filereadable(colorscheme_file) == 1 then
				local file = io.open(colorscheme_file, "r")
				if file then
					local content = file:read("*all"):gsub("%s+", "")
					if content and #content > 0 then
						colorscheme = content
					end
					file:close()
				end
			end

			-- Apply the colorscheme
			vim.cmd.colorscheme(colorscheme)
			vim.cmd.hi("Comment gui=none")
		end,
	},
}
