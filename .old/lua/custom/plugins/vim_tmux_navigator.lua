return {
	{
		"christoomey/vim-tmux-navigator",
		vim.keymap.set({"n", "v", "i"}, "<C-h>", "<cmd>TmuxNavigateLeft<CR>"),
		vim.keymap.set({"n", "v", "i"}, "<C-l>", "<cmd>TmuxNavigateRight<CR>"),
		vim.keymap.set({"n", "v", "i"}, "<C-j>", "<cmd>TmuxNavigateDown<CR>"),
		vim.keymap.set({"n", "v", "i"}, "<C-k>", "<cmd>TmuxNavigateUp<CR>"),
	},
}
