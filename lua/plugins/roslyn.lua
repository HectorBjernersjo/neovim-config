-- return {
--     {
--         "seblyng/roslyn.nvim",
--         ft = "cs",
--         opts = {
--             root_dir = function(fname)
--                 -- 1. Search for the solution file first.
--                 local sln_files = vim.fs.find({ '*.sln' }, {
--                     upward = true,
--                     path = fname,
--                 })
--
--                 if #sln_files > 0 then
--                     return vim.fn.fnamemodify(sln_files[1], ':h')
--                 end
--
--                 -- 2. If no solution, *then* search for a project file.
--                 local csproj_files = vim.fs.find({ '*.csproj' }, {
--                     upward = true,
--                     path = fname,
--                 })
--
--                 if #csproj_files > 0 then
--                     return vim.fn.fnamemodify(csproj_files[1], ':h')
--                 end
--
--                 -- 3. If neither is found, return nil.
--                 return nil
--             end,
--         },
--     },
-- }

-- return {
--     {
--         "seblyng/roslyn.nvim",
--     }
-- }

-- return {
--     {
--         "seblyng/roslyn.nvim",
--         ft = { "cs", "razor" },
--         dependencies = {
--             {
--                 -- By loading as a dependencies, we ensure that we are available to set
--                 -- the handlers for Roslyn.
--                 "tris203/rzls.nvim",
--                 -- dir = "~/Documents/dev/others/rzls.nvim/",
--                 config = true,
--             },
--         },
--         config = function()
--             local mason_registry = require("mason-registry")
--
--             local rzls_path = vim.fn.expand("$MASON/packages/rzls/libexec")
--             local cmd = {
--                 "roslyn",
--                 "--stdio",
--                 "--logLevel=Error",
--                 "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
--                 "--razorSourceGenerator=" .. vim.fs.joinpath(rzls_path, "Microsoft.CodeAnalysis.Razor.Compiler.dll"),
--                 "--razorDesignTimePath=" ..
--                 vim.fs.joinpath(rzls_path, "Targets", "Microsoft.NET.Sdk.Razor.DesignTime.targets"),
--                 "--extension",
--                 vim.fs.joinpath(rzls_path, "RazorExtension", "Microsoft.VisualStudioCode.RazorExtension.dll"),
--             }
--
--             vim.lsp.config("roslyn", {
--                 cmd = cmd,
--                 handlers = require("rzls.roslyn_handlers"),
--                 settings = {
--                     ["csharp|inlay_hints"] = {
--                         csharp_enable_inlay_hints_for_implicit_object_creation = true,
--                         csharp_enable_inlay_hints_for_implicit_variable_types = true,
--
--                         csharp_enable_inlay_hints_for_lambda_parameter_types = true,
--                         csharp_enable_inlay_hints_for_types = true,
--                         dotnet_enable_inlay_hints_for_indexer_parameters = true,
--                         dotnet_enable_inlay_hints_for_literal_parameters = true,
--                         dotnet_enable_inlay_hints_for_object_creation_parameters = true,
--                         dotnet_enable_inlay_hints_for_other_parameters = true,
--                         dotnet_enable_inlay_hints_for_parameters = true,
--                         dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
--                         dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
--                         dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
--                     },
--                     ["csharp|code_lens"] = {
--                         dotnet_enable_references_code_lens = true,
--                     },
--                 },
--             })
--             vim.lsp.enable("roslyn")
--
--             vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
--                 group = vim.api.nvim_create_augroup("IgnoreUnsavedChanges", { clear = true }),
--                 pattern = "*__virtual.html",
--                 callback = function()
--                     vim.bo.buftype = "nofile"
--                 end
--             })
--
--             vim.api.nvim_create_autocmd("BufWriteCmd", {
--                 group = vim.api.nvim_create_augroup("DontSave__virtualFiles", { clear = true }),
--                 pattern = "*__virtual.html",
--                 callback = function()
--                     vim.cmd('echom "Skipping save for __virtual.html file"')
--                 end
--             })
--         end,
--         init = function()
--             -- We add the Razor file types before the plugin loads.
--             vim.filetype.add({
--                 extension = {
--                     razor = "razor",
--                     cshtml = "razor",
--                 },
--             })
--         end,
--     },
-- }
--
--

return {
    {
        "seblyng/roslyn.nvim",
        ---@module 'roslyn.config'
        ---@type RoslynNvimConfig
        ft = { "cs", "razor" },
        opts = {
            -- your configuration comes here; leave empty for default settings
        },

        -- ADD THIS:

        dependencies = {
            {
                -- By loading as a dependencies, we ensure that we are available to set
                -- the handlers for Roslyn.
                "tris203/rzls.nvim",
                config = true,
            },
        },
        lazy = false,
        config = function()
            -- Use one of the methods in the Integration section to compose the command.
            local mason_registry = require("mason-registry")

            local rzls_path = vim.fn.expand("$MASON/packages/rzls/libexec")
            local cmd = {
                "roslyn",
                "--stdio",
                "--logLevel=Information",
                "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
                "--razorSourceGenerator=" .. vim.fs.joinpath(rzls_path, "Microsoft.CodeAnalysis.Razor.Compiler.dll"),
                "--razorDesignTimePath=" ..
                vim.fs.joinpath(rzls_path, "Targets", "Microsoft.NET.Sdk.Razor.DesignTime.targets"),
                "--extension",
                vim.fs.joinpath(rzls_path, "RazorExtension", "Microsoft.VisualStudioCode.RazorExtension.dll"),
            }

            vim.lsp.config("roslyn", {
                cmd = cmd,
                handlers = require("rzls.roslyn_handlers"),
                settings = {
                    ["csharp|inlay_hints"] = {
                        csharp_enable_inlay_hints_for_implicit_object_creation = true,
                        csharp_enable_inlay_hints_for_implicit_variable_types = true,

                        csharp_enable_inlay_hints_for_lambda_parameter_types = true,
                        csharp_enable_inlay_hints_for_types = true,
                        dotnet_enable_inlay_hints_for_indexer_parameters = true,
                        dotnet_enable_inlay_hints_for_literal_parameters = true,
                        dotnet_enable_inlay_hints_for_object_creation_parameters = true,
                        dotnet_enable_inlay_hints_for_other_parameters = true,
                        dotnet_enable_inlay_hints_for_parameters = true,
                        dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
                        dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
                        dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
                    },
                    ["csharp|code_lens"] = {
                        dotnet_enable_references_code_lens = true,
                    },
                },
            })
            vim.lsp.enable("roslyn")
        end,
        init = function()
            -- We add the Razor file types before the plugin loads.
            vim.filetype.add({
                extension = {
                    razor = "razor",
                    cshtml = "razor",
                },
            })
        end,
    },
}
