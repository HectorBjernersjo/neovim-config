return {
    "seblyng/roslyn.nvim",
    ft = "cs",
    opts = {},
    config = function(_, opts)
        local custom_handlers = require("custom.lsp.handlers")

        vim.lsp.config("roslyn", {
            on_attach = custom_handlers.on_attach,
            settings = {
                ["csharp|code_lens"] = {
                    dotnet_enable_references_code_lens = true,
                },
            },
        })

        require("roslyn").setup(opts)
    end,
}

-- return {
--     {
--         "seblyng/roslyn.nvim",
--         ft = { "cs" },
--         dependencies = {
--             {
--                 "tris203/rzls.nvim",
--                 config = true,
--             },
--         },
--         config = function()
--             -- Adjust these paths to where you installed Roslyn and rzls.
--
--             local roslyn_base_path = vim.fs.joinpath(vim.fn.stdpath("data"), "roslyn")
--             local cmd = {
--                 "dotnet",
--                 "/home/hector/roslyn/artifacts/bin/Microsoft.CodeAnalysis.LanguageServer/Debug/net9.0/Microsoft.CodeAnalysis.LanguageServer.dll",
--                 "--stdio",
--                 "--logLevel=Information",
--                 "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
--                 "--razorSourceGenerator='/home/hector/razor/artifacts/bin/Microsoft.AspNetCore.Razor.LanguageServer/Debug/net9.0/Microsoft.CodeAnalysis.Razor.Compiler.dll'",
--                 "--razorDesignTimePath='/home/hector/razor/src/Razor/src/rzls/Targets/Microsoft.NET.Sdk.Razor.DesignTime.targets'",
--             }
--
--             vim.lsp.config("roslyn", {
--                 cmd = cmd,
--                 handlers = require("rzls.roslyn_handlers"),
--                 settings = {
--                 },
--             })
--             vim.lsp.enable("roslyn")
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


-- return {
--     {
--         "seblyng/roslyn.nvim",
--         ft = { "cs", "razor" },
--         dependencies = {
--             {
--                 -- By loading as a dependencies, we ensure that we are available to set
--                 -- the handlers for Roslyn.
--                 "tris203/rzls.nvim",
--                 config = true,
--             },
--         },
--         config = function()
--             -- Use one of the methods in the Integration section to compose the command.
--             local mason_registry = require("mason-registry")
--
--             ---@type string[]
--             local cmd = {}
--
--             local roslyn_package = mason_registry.get_package("roslyn")
--             if roslyn_package:is_installed() then
--                 vim.list_extend(cmd, {
--                     "roslyn",
--                     "--stdio",
--                     "--logLevel=Information",
--                     "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
--                 })
--
--                 local rzls_package = mason_registry.get_package("rzls")
--                 if rzls_package:is_installed() then
--                     local rzls_path = vim.fn.expand("$MASON/packages/rzls/libexec")
--                     table.insert(
--                         cmd,
--                         "--razorSourceGenerator="
--                         .. vim.fs.joinpath(rzls_path, "Microsoft.CodeAnalysis.Razor.Compiler.dll")
--                     )
--                     table.insert(
--                         cmd,
--                         "--razorDesignTimePath="
--                         .. vim.fs.joinpath(rzls_path, "Targets", "Microsoft.NET.Sdk.Razor.DesignTime.targets")
--                     )
--                     vim.list_extend(cmd, {
--                         "--extension",
--                         vim.fs.joinpath(rzls_path, "RazorExtension", "Microsoft.VisualStudioCode.RazorExtension.dll"),
--                     })
--                 end
--             end
--             require("roslyn").setup({
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
