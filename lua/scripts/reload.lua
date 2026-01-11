vim.api.nvim_create_user_command("ReloadConfig", function()
	for name, _ in pairs(package.loaded) do
		if name:match("^user") or name:match("^plugins") then
			package.loaded[name] = nil
		end
	end
	dofile(vim.fn.stdpath("config") .. "/init.lua")
	print("🔄 Config reloaded!")
end, {})
