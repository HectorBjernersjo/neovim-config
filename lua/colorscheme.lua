return {
	{ "catppuccin/nvim", event = "VeryLazy" },
	{ "sainnhe/gruvbox-material", event = "VeryLazy" },
	{ "rebelot/kanagawa.nvim", event = "VeryLazy" },
	{ "rose-pine/neovim", event = "VeryLazy" },
	{
		"neanias/everforest-nvim",
		version = false,
		event = "VeryLazy",
		priority = 1000, -- make sure to load this before all the other start plugins
		-- Optional; default configuration will be used if setup isn't called.
		config = function()
			require("everforest").setup({
				-- Your config here
			})
		end,
	},
	{
		"maxmx03/solarized.nvim",
		event = "VeryLazy",
		-- config = function()
		-- 	vim.o.background = "dark" -- or 'light'
		-- 	-- vim.cmd.colorscheme("solarized")
		-- end,
	},
	{
		"folke/tokyonight.nvim",
		priority = 1000, -- Make sure to load this before all the other start plugins.
		init = function()
			-- Set default colorscheme
			local colorscheme = "tokyonight-night"
			local background = "dark"

			-- Path to the colorscheme file
			local colorscheme_file = vim.fn.stdpath("config") .. "/colorscheme.txt"
			local background_file = vim.fn.stdpath("config") .. "/background.txt"

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

			-- Check if the file exists and read the colorscheme from it
			if vim.fn.filereadable(background_file) == 1 then
				local file = io.open(background_file, "r")
				if file then
					local content = file:read("*all"):gsub("%s+", "")
					if content and #content > 0 then
						background = content
					end
					file:close()
				end
			end

			-- Apply the colorscheme
			vim.cmd.colorscheme(colorscheme)
			vim.cmd("set background=" .. background)
			-- vim.cmd("set background=light")
			vim.cmd.hi("Comment gui=none")
		end,
	},
}
