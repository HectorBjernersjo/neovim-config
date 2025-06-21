-- Function to list all keymaps
local function list_keymaps()
	local modes = { "n", "i", "v", "c", "x", "s", "o", "t", "l" }
	for _, mode in ipairs(modes) do
		print("Mode: " .. mode)
		local keymaps = vim.api.nvim_get_keymap(mode)
		for _, keymap in ipairs(keymaps) do
			print(vim.inspect(keymap))
		end
	end
end

-- Command to list all keymaps
vim.api.nvim_create_user_command("ListKeymaps", list_keymaps, {})
