local function get_base()
    local candidates = { "origin/master", "origin/main", "master", "main" }
    local best_ref = nil
    local best_timestamp = -1

    for _, ref in ipairs(candidates) do
        local timestamp = vim.fn.system("git log -1 --format=%ct " .. ref .. " 2>/dev/null")
        if vim.v.shell_error == 0 and timestamp ~= "" then
            local ts = tonumber(vim.trim(timestamp))
            if ts and ts > best_timestamp then
                best_timestamp = ts
                best_ref = ref
            end
        end
    end

    return best_ref or "origin/main"
end

return {
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("gitsigns").setup({
                base = get_base(),
            })
        end,
    }
}
