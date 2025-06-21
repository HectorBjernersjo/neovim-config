return {
	{
		"ThePrimeagen/harpoon",
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("harpoon").setup({
				global_settings = {
					save_on_toggle = false,
					save_on_change = true,
					excluded_filetypes = { "harpoon" },
					mark_branch = true,
				},
			})

			-- Use telescope
			require("telescope").load_extension("harpoon")

			local mark = require("harpoon.mark")
			local ui = require("harpoon.ui")
			-- Key mappings
			vim.keymap.set("n", "<leader>d", mark.add_file, { desc = "Harpoon Add File" })
			vim.keymap.set("n", "<leader>l", ui.toggle_quick_menu, { desc = "Harpoon Toggle Menu" })

			vim.keymap.set("n", "<leader>1", function()
				ui.nav_file(1)
			end, { desc = "Harpoon Goto File 1" })

			vim.keymap.set("n", "<leader>2", function()
				ui.nav_file(2)
			end, { desc = "Harpoon Goto File 2" })

			vim.keymap.set("n", "<leader>3", function()
				ui.nav_file(3)
			end, { desc = "Harpoon Goto File 3" })

			vim.keymap.set("n", "<leader>4", function()
				ui.nav_file(4)
			end, { desc = "Harpoon Goto File 4" })
            
			vim.keymap.set("n", "<leader>5", function()
				ui.nav_file(5)
			end, { desc = "Harpoon Goto File 5" })

			vim.keymap.set("n", "<leader>6", function()
				ui.nav_file(6)
			end, { desc = "Harpoon Goto File 6" })

			-- vim.keymap.set('n', '<C-H>', require('harpoon.ui').nav_prev, { desc = 'Harpoon Previous' })
			-- vim.keymap.set('n', '<C-L>', require('harpoon.ui').nav_next, { desc = 'Harpoon Next' })
		end,
	},
}
