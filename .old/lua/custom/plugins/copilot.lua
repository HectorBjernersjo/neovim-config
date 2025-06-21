local function get_copilot_state()
	local state_file = vim.fn.stdpath("data") .. "/copilot_state"
	local file = io.open(state_file, "r")
	if file then
		local state = file:read("*all")
		file:close()
		return state
	end
	return "enabled" -- Default state
end

local function set_copilot_state(state)
	local state_file = vim.fn.stdpath("data") .. "/copilot_state"
	local file = io.open(state_file, "w")
	if file then
		file:write(state)
		file:close()
	end
end

return {
	{
		"github/copilot.vim",
		config = function()
			-- Read the initial state
			local state = get_copilot_state()
			if state == "enabled" then
				vim.cmd("Copilot enable")
			else
				vim.cmd("Copilot disable")
			end

			-- Define key mappings to enable/disable Copilot and update the state file
			vim.keymap.set("n", "<leader>ce", function()
				vim.cmd("Copilot enable")
				set_copilot_state("enabled")
			end, { noremap = true, silent = true })

			vim.keymap.set("n", "<leader>cd", function()
				vim.cmd("Copilot disable")
				set_copilot_state("disabled")
			end, { noremap = true, silent = true })
		end,
	},
}
