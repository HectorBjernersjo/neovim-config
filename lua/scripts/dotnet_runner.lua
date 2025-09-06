-- =============================================================================
-- Neovim Command to find and run C# projects in Tmux
--
-- Dependencies:
--   - A fuzzy-finder plugin like 'telescope.nvim' or 'fzf-lua'. This example
--     is adapted for the general concept and uses a placeholder picker.
--     I will use `vim.ui.select` which can be backed by any of those.
--   - The 'tmuxhelper.sh' script from our previous conversation, accessible
--     in your PATH.
--
-- Installation:
-- 1. Place this code in a file that gets loaded by your Neovim config
--    (e.g., in `lua/custom/tmux_runner.lua`).
-- 2. "require" it from your main `init.lua` if needed: `require('custom.tmux_runner')`
-- 3. The script creates the commands and keymaps for you.
-- =============================================================================


-- =============================================================================
-- CORE LOGIC
-- =============================================================================

-- This internal function contains the shared logic for finding and running a project.
-- It accepts an 'opts' table to allow for variations.
-- @param opts: A table with options, e.g., { with_ts = true }
local function run_project(opts)
    opts = opts or {}

    -- Use vim.fn.glob to find all .csproj files recursively from the current directory.
    -- This is a built-in alternative if you don't want a fuzzy-finder dependency.
    local csproj_files = vim.fn.glob(vim.fn.getcwd() .. '/**/*.csproj', true, true)
    if vim.v.shell_error ~= 0 or #csproj_files == 0 then
        vim.notify("No .csproj files found in the current directory or subdirectories.", vim.log.levels.WARN)
        return
    end

    -- Use vim.ui.select, which is Neovim's modern, pluggable UI function.
    -- It can be backed by telescope, fzf-lua, or a default picker.
    vim.ui.select(csproj_files, {
        prompt = "Select a .csproj to Run in Tmux",
    }, function(selected_item)
        -- Exit if the user cancelled the selection (e.g., by pressing Esc).
        if not selected_item then
            vim.notify("Project selection cancelled.", vim.log.levels.INFO)
            return
        end

        -- 1. Get the directory from the full file path.
        local dir_path = vim.fn.fnamemodify(selected_item, ":h")

        -- 2. Construct the shell command to execute.
        local ts_flag = ""
        if opts.with_ts then
            ts_flag = "--ts "
        end
        --
        -- Dynamically find your Neovim config directory
        local config_path = vim.fn.stdpath('config')

        -- Define the paths to your runner and helper scripts
        local runner_script = config_path .. "/scripts/dotnet-runner.sh"
        local helper_script = config_path .. "/scripts/tmuxhelper.sh"

        -- We use vim.fn.shellescape to ensure the path is correctly quoted.
        local cmd = string.format("%s %s%s", runner_script, helper_script, ts_flag, vim.fn.shellescape(dir_path))

        -- 3. Execute the command in the background.
        -- Using vim.fn.jobstart() is non-blocking, so it won't freeze Neovim.
        vim.fn.jobstart(cmd, {
            on_exit = function(_, exit_code)
                if exit_code == 0 then
                    vim.notify("Tmux runner script executed successfully for: " .. dir_path, vim.log.levels.INFO)
                else
                    vim.notify("Tmux runner script failed for: " .. dir_path, vim.log.levels.ERROR)
                end
            end,
        })
    end)
end

-- =============================================================================
-- PUBLIC FUNCTIONS
-- =============================================================================

--- A public function to find and run a project WITHOUT the TypeScript compiler.
local function find_and_run_project()
    run_project({ with_ts = false })
end

--- A public function to find and run a project WITH the TypeScript compiler.
local function find_and_run_project_with_ts()
    run_project({ with_ts = true })
end


-- =============================================================================
-- SETUP
-- =============================================================================

-- Create a User Command for the standard run
vim.api.nvim_create_user_command(
    "RP",
    find_and_run_project,
    { desc = "Find a .csproj and run its directory with the tmux runner script" }
)

-- Create a User Command for the run with TypeScript
vim.api.nvim_create_user_command(
    "RPT",
    find_and_run_project_with_ts,
    { desc = "Find a .csproj and run it AND a TS compiler with the tmux runner script" }
)

-- --- Keymaps ---

-- Keymap for the standard run. Maps `<leader>tr` (for "Tmux Run").
vim.keymap.set("n", "<leader>tr", "<cmd>RP<cr>", {
    noremap = true,
    silent = true,
    desc = "Run C# project in Tmux",
})

-- Keymap for the run with TypeScript. Maps `<leader>ts` (for "Tmux TS").
vim.keymap.set("n", "<leader>ts", "<cmd>RPT<cr>", {
    noremap = true,
    silent = true,
    desc = "Run C# project with TS compiler in Tmux",
})
