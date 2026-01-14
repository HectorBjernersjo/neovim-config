if vim.v.hlsearch == 1 then
    local sinfo = vim.fn.searchcount { maxcount = 0 }
    local search_stat = sinfo.incomplete > 0 and '[?/?]'
        or sinfo.total > 0 and ('[%s/%s]'):format(sinfo.current, sinfo.total)
        or nil

    if search_stat ~= nil then
        -- add search_stat to statusline/winbar
    end
end
