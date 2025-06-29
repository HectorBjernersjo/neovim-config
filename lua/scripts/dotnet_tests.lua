-- =============================================================================
-- Dotnet Testing Integration
--
-- Description:
-- This script provides functionality to run .NET tests from within Neovim
-- using the 'dotnet-tester.sh' script.
--
-- Commands:
--   :WhereAmI        - Displays the fully qualified name of the symbol under the cursor.
--   :RunTest         - Runs the specific test method under the cursor.
--   :RunTestClass    - Runs all tests in the class under the cursor.
--
-- Setup:
-- 1. Place this file in your Neovim configuration directory (e.g., '~/.config/nvim/lua/plugin/dotnet-testing.lua').
-- 2. Make sure the `dotnet-tester.sh` script is executable (`chmod +x /path/to/dotnet-tester.sh`).
-- 3. Update the `vim.g.dotnet_tester_script_path` variable below to point to your script.
-- =============================================================================

-- =============================================================================
-- Configuration
-- =============================================================================
-- IMPORTANT: Set this path to your dotnet-tester.sh script
vim.g.dotnet_tester_script_path = 'dotnet_tester.sh'

-- =============================================================================
-- Polyfill for users on Neovim < 0.8.0
-- This function replicates vim.lsp.util.find_containing_symbol
-- =============================================================================
local function find_containing_symbol_fallback(symbols, pos)
    -- The cursor position from nvim_win_get_cursor is 1-based, but LSP is 0-based.
    local cursor_line = pos[1] - 1

    local path = {}
    local function search(nodes)
        for _, node in ipairs(nodes) do
            local start_line = node.range.start.line
            local end_line = node.range['end'].line -- 'end' is a keyword
            if cursor_line >= start_line and cursor_line <= end_line then
                table.insert(path, node)
                -- Search children to find the most specific (innermost) symbol
                if node.children and #node.children > 0 then
                    search(node.children)
                end
                -- Once we find a containing symbol at a certain level, we don't need
                -- to check its siblings, as they can't also contain the cursor.
                return
            end
        end
    end

    search(symbols)
    return #path > 0 and path or nil
end

-- =============================================================================
-- Helper Functions
-- =============================================================================

--- Finds the root directory of the project containing the current buffer.
--- Searches upwards from the buffer's directory for a '*.csproj' file.
---@return string|nil The path to the project directory, or nil if not found.
local function find_project_root()
    local current_buf_path = vim.api.nvim_buf_get_name(0)
    if not current_buf_path or current_buf_path == "" then
        vim.notify("Could not determine buffer path.", vim.log.levels.WARN)
        return nil
    end

    local dir = vim.fn.fnamemodify(current_buf_path, ":h")
    while dir ~= "/" and dir ~= "" do
        local csproj_files = vim.fn.glob(dir .. "/*.csproj", false, true)
        if #csproj_files > 0 then
            return dir
        end
        dir = vim.fn.fnamemodify(dir, ":h")
    end
    -- Fallback to the current buffer's directory if no csproj is found
    return vim.fn.fnamemodify(current_buf_path, ":h")
end

--- Retrieves the fully qualified path of the symbol at the cursor.
---@param scope 'method' | 'class' The desired scope ('method' for the full N.C.M path, 'class' for just N.C).
---@param callback fun(fqn: string|nil, project_dir: string|nil)
local function get_symbol_path_and_run(scope, callback)
    local bufnr = vim.api.nvim_get_current_buf()
    local pos = vim.api.nvim_win_get_cursor(0)
    local params = vim.lsp.util.make_position_params()

    vim.lsp.buf_request(bufnr, 'textDocument/documentSymbol', params, function(err, result)
        if err or not result or #result == 0 then
            vim.notify("LSP: Could not determine current symbols.", vim.log.levels.WARN)
            return callback(nil, nil)
        end

        -- Find symbol path (namespace, class, method)
        local find_symbol_func = vim.lsp.util.find_containing_symbol or find_containing_symbol_fallback
        local symbols_at_cursor = find_symbol_func(result, pos)

        -- Find namespace via text search
        local namespace_name = nil
        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
        for _, line in ipairs(lines) do
            if line:match("^%s*namespace%s+") then
                namespace_name = line:gsub("^%s*namespace%s+", ""):gsub(";", ""):gsub("%s*$", "")
                break
            end
        end

        local names = {}
        if symbols_at_cursor then
            names = vim.tbl_map(function(symbol) return symbol.name end, symbols_at_cursor)
        end

        if namespace_name then
            table.insert(names, 1, namespace_name)
        end

        if #names == 0 then
            vim.notify("Could not determine current location.", vim.log.levels.INFO)
            return callback(nil, nil)
        end

        -- Determine the fully qualified name based on the requested scope
        local fqn
        if scope == 'class' then
            -- Join only the namespace and class name (first two elements)
            fqn = table.concat({ names[1], names[2] }, ".")
        else -- Default to 'method'
            fqn = table.concat(names, ".")
        end

        local project_dir = find_project_root()
        if not project_dir then
            vim.notify("Could not find project root (.csproj file).", vim.log.levels.ERROR)
            return callback(nil, nil)
        end

        callback(fqn, project_dir)
    end)
end

--- Executes the dotnet-tester.sh script.
---@param test_name string The fully qualified name of the test/class to run.
---@param project_dir string The directory of the test project.
local function run_tester_script(test_name, project_dir)
    local script_path = vim.g.dotnet_tester_script_path
    -- if vim.fn.filereadable(script_path) == 0 then
    --     vim.notify("Dotnet tester script not found at: " .. script_path, vim.log.levels.ERROR)
    --     vim.notify("Please configure 'vim.g.dotnet_tester_script_path' in your vimrc.", vim.log.levels.ERROR)
    --     return
    -- end

    local command = {
        script_path,
        test_name,
        project_dir
    }

    vim.notify("Running test: " .. test_name, vim.log.levels.INFO, { title = ".NET Test" })
    vim.fn.jobstart(command, {
        on_exit = function(_, exit_code)
            if exit_code == 0 then
                vim.schedule(function()
                    vim.notify("Test runner script finished successfully.", vim.log.levels.INFO, { title = ".NET Test" })
                end)
            else
                vim.schedule(function()
                    vim.notify("Test runner script exited with code: " .. exit_code, vim.log.levels.ERROR,
                        { title = ".NET Test" })
                end)
            end
        end
    })
end

-- =============================================================================
-- User Commands
-- =============================================================================

--- The WhereAmI Command (for debugging)
vim.api.nvim_create_user_command(
    "WhereAmI",
    function()
        get_symbol_path_and_run('method', function(fqn, _)
            if fqn then
                vim.notify(fqn, vim.log.levels.INFO, { title = "Current Location" })
            end
        end)
    end,
    {
        desc = "Shows the current function/class context using LSP.",
    }
)

--- RunTest Command (Single Test)
vim.api.nvim_create_user_command(
    "RunTest",
    function()
        get_symbol_path_and_run('method', function(fqn, project_dir)
            if fqn and project_dir then
                run_tester_script(fqn, project_dir)
            end
        end)
    end,
    {
        desc = "Runs the .NET test under the cursor using dotnet-tester.sh",
    }
)

--- RunTestClass Command (All tests in a class)
vim.api.nvim_create_user_command(
    "RunTestClass",
    function()
        get_symbol_path_and_run('class', function(fqn, project_dir)
            if fqn and project_dir then
                -- The dotnet filter works with just the class name to run all its tests
                run_tester_script(fqn, project_dir)
            end
        end)
    end,
    {
        desc = "Runs all .NET tests in the current class using dotnet-tester.sh",
    }
)
