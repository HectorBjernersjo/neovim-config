--[[=================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||     HECTOR.nvim    ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=================================================================--]]

require("options")
require("keymaps")
require("autocommands")

require("lazy").setup({
	require("colorscheme"),
	-- My own Requirements
	require("custom.plugins.harpoon"),
	require("custom.plugins.undotree"),
	require("custom.plugins.vimbegood"),
	require("custom.plugins.simple"),
	require("custom.plugins.whichkeys"),
	require("custom.plugins.gitsigns"),
	require("custom.plugins.telescope"),
	require("custom.plugins.lspconfig"),
	require("custom.plugins.autoformat"),
	require("custom.plugins.autocomplete"),
	-- require("custom.plugins.tokyonight"),
	require("custom.plugins.mini"),
	require("custom.plugins.treesitter"),
	require("custom.plugins.noice"),
	require("custom.plugins.dashboard"),
	require("custom.plugins.copilot"),

	require("kickstart.plugins.debug"),
	require("kickstart.plugins.autopairs"),
	--
	-- require 'kickstart.plugins.indent_line',
	-- require 'kickstart.plugins.lint',
	-- require 'kickstart.plugins.neo-tree',
	-- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps
}, {
	ui = {
		-- If you are using a Nerd Font: set icons to an empty table which will use the
		-- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
