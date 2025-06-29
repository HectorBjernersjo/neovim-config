return {
    {
        "rachartier/tiny-code-action.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
        },
        event = "LspAttach",
        opts = {
            --- The backend to use, currently only "vim", "delta", "difftastic", "diffsofancy" are supported
            backend = "vim",

            -- The picker to use, "telescope", "snacks", "select" are supported
            -- And it's opts that will be passed at the picker's creation, optional
            -- If you want to use the `fzf-lua` picker, you can simply set it to `select`
            --
            -- You can also set `picker = "telescope"` without any opts.
            picker = {
                "snacks",
                opts = {
                    layout_strategy = "vertical",
                    layout_config = {
                        width = 0.7,
                        height = 0.9,
                        preview_cutoff = 1,
                        preview_height = function(_, _, max_lines)
                            local h = math.floor(max_lines * 0.5)
                            return math.max(h, 10)
                        end,
                    },
                },
            },
            backend_opts = {
                delta = {
                    -- Header from delta can be quite large.
                    -- You can remove them by setting this to the number of lines to remove
                    header_lines_to_remove = 4,

                    -- The arguments to pass to delta
                    -- If you have a custom configuration file, you can set the path to it like so:
                    -- args = {
                    --     "--config" .. os.getenv("HOME") .. "/.config/delta/config.yml",
                    -- }
                    args = {
                        "--line-numbers",
                    },
                },
                difftastic = {
                    header_lines_to_remove = 1,

                    -- The arguments to pass to difftastic
                    args = {
                        "--color=always",
                        "--display=inline",
                        "--syntax-highlight=on",
                    },
                },
                diffsofancy = {
                    header_lines_to_remove = 4,
                }
            },

            -- The icons to use for the code actions
            -- You can add your own icons, you just need to set the exact action's kind of the code action
            -- You can set the highlight like so: { link = "DiagnosticError" } or  like nvim_set_hl ({ fg ..., bg..., bold..., ...})
            signs = {
                quickfix = { "󰁨", { link = "DiagnosticInfo" } },
                others = { "?", { link = "DiagnosticWarning" } },
                refactor = { "", { link = "DiagnosticWarning" } },
                ["refactor.move"] = { "󰪹", { link = "DiagnosticInfo" } },
                ["refactor.extract"] = { "", { link = "DiagnosticError" } },
                ["source.organizeImports"] = { "", { link = "DiagnosticWarning" } },
                ["source.fixAll"] = { "", { link = "DiagnosticError" } },
                ["source"] = { "", { link = "DiagnosticError" } },
                ["rename"] = { "󰑕", { link = "DiagnosticWarning" } },
                ["codeAction"] = { "", { link = "DiagnosticError" } },
            },
        }
    }
}
