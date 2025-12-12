local dap = require('dap')

dap.adapters.coreclr = {
    type = 'executable',
    command = '/home/hector/netcoredbg/bin/netcoredbg',
    args = { '--interpreter=vscode' }
}

-- Walk upwards from a starting directory to find a given file
local function find_upwards(start_dir, target)
    local dir = vim.fn.fnamemodify(start_dir, ":p")
    while dir and dir ~= "" do
        local candidate = dir .. "/" .. target
        if vim.fn.filereadable(candidate) == 1 then
            return vim.fn.fnamemodify(candidate, ":p")
        end
        local parent = vim.fn.fnamemodify(dir, ":h")
        if parent == dir then
            break
        end
        dir = parent
    end
end

dap.configurations.cs = {
    {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        env = {
            ASPNETCORE_ENVIRONMENT = "Development",
            ASPNETCORE_URLS = "https://localhost:56866;http://localhost:56867",
            -- FLEXHRM_APPSETTINGS_PATH will be resolved dynamically per project
        },
        program = function()
            return coroutine.create(function(dap_run_co)
                local items = {}
                local csprojs = vim.fn.glob("**/*.csproj", false, true)

                for _, csproj in ipairs(csprojs) do
                    local filename = vim.fn.fnamemodify(csproj, ":t:r")
                    local dirname = vim.fn.fnamemodify(csproj, ":h")
                    -- Find the dll with the exact same name in bin/Debug (handles net8.0 etc)
                    local pattern = dirname .. "/bin/Debug/**/" .. filename .. ".dll"
                    local dlls = vim.fn.glob(pattern, false, true)

                    for _, dll in ipairs(dlls) do
                        local dll_abs = vim.fn.fnamemodify(dll, ":p")
                        local project_dir_abs = vim.fn.fnamemodify(dirname, ":p")
                        table.insert(items, {
                            text = dll_abs,
                            file = dll_abs,
                            project_dir = project_dir_abs,
                        })
                    end
                end

                require("snacks").picker.pick({
                    items = items,
                    layout = { preset = "vscode" },
                    confirm = function(picker, item)
                        picker:close()
                        if item then
                            -- Derive content root and appsettings path dynamically from the selected project
                            local project_dir = item.project_dir or vim.fn.fnamemodify(item.file, ":h")
                            local cfg = dap.configurations.cs[1]
                            if cfg then
                                cfg.cwd = project_dir
                                cfg.env = cfg.env or {}
                                cfg.env.ASPNETCORE_CONTENTROOT = project_dir

                                -- Try to locate parentsettings.config by walking up from the project directory
                                local settings = find_upwards(project_dir, "parentsettings.config")
                                if settings and settings ~= "" then
                                    cfg.env.FLEXHRM_APPSETTINGS_PATH = settings
                                end
                            end

                            coroutine.resume(dap_run_co, item.file)
                        end
                    end,
                })
            end)
        end,
    },
}
