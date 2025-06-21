function SetupSingleFileCSharp()
    local temp_project_dir = vim.fn.stdpath("data") .. "/temp_csharp_project/TempCSharpProject"
    if not vim.loop.fs_stat(temp_project_dir) then
        vim.fn.mkdir(temp_project_dir, "p")
        vim.fn.system({ "dotnet", "new", "console", "-n", "TempCSharpProject", "-o", temp_project_dir })
    end

    local bufnr = vim.api.nvim_get_current_buf()
    local filename = vim.api.nvim_buf_get_name(bufnr)
    local temp_cs_file = temp_project_dir .. "/Program.cs"

    -- Save the current buffer before switching to the new file
    vim.cmd("write")

    -- Copy the contents of the current buffer to the temp project's Program.cs
    vim.fn.writefile(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), temp_cs_file)

    -- Switch to the temp project's Program.cs
    vim.cmd("edit " .. temp_cs_file)

    -- Manually start the LSP client for OmniSharp
    vim.lsp.start_client({
        name = "omnisharp",
        cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()), "-z" },
        root_dir = temp_project_dir,
        capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
    })
end

vim.api.nvim_create_user_command("SetupSingleFileCSharp", SetupSingleFileCSharp, {})
