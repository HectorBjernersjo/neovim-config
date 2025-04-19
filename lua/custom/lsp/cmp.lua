-- lua/custom/lsp/cmp.lua
local M = {}

function M.setup()
    local cmp     = require("cmp")
    local luasnip = require("luasnip")

    require("luasnip.loaders.from_vscode").lazy_load()

    ---@diagnostic disable-next-line: param-type-mismatch
    cmp.setup({
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        mapping = cmp.mapping.preset.insert({
            ["<C-n>"]     = cmp.mapping.select_next_item(),
            ["<C-p>"]     = cmp.mapping.select_prev_item(),
            ["<C-b>"]     = cmp.mapping.scroll_docs(-4),
            ["<C-f>"]     = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-e>"]     = cmp.mapping.abort(),
            ["<CR>"]      = cmp.mapping.confirm({ select = true }),
            ["<C-y>"]     = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "dap" },
        }, {
            { name = "buffer" },
        }),
    })

    cmp.setup({
        enabled = function()
            return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
                or require("cmp_dap").is_dap_buffer()
        end,
    })

    cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
        sources = {
            { name = "dap" },
            { name = "nvim_lsp" },
            { name = "path" },
            { name = "buffer" },
        },
    })

    -- ─────────────────────────────────────────────────────────
    -- → NEW: enable command‑line (`:`) completion via cmp‑cmdline
    -- First install "hrsh7th/cmp-cmdline" if you haven’t already
    -- and add it to your cmp dependencies.

    cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = "path" }, -- file paths
        }, {
            { name = "cmdline" }, -- Vim commands
        }),
    })
    -- ─────────────────────────────────────────────────────────
end

return M
