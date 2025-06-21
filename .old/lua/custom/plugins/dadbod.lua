-- In your plugins configuration file (e.g., plugins/dadbod.lua)
return {
  -- Plugin 1: The Core Dadbod Engine
  -- This plugin's only job is to set up the global database variable.
  {
    'tpope/vim-dadbod',
    config = function()
      vim.g.dbs = {
        ['Robin'] = 'sqlserver://sa:HejHoj1!@localhost/?database=robin&TrustServerCertificate=True',
      }
    end,
  },

  -- Plugin 2: The Dadbod UI
  -- This depends on the core engine. All UI keymaps and commands live here.
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = { 'tpope/vim-dadbod' },
    config = function()
      -- Global keymaps to control the UI
      vim.keymap.set('n', '<Leader>db', '<Cmd>DBUIToggle<CR>', { desc = 'Toggle DBUI' })
      vim.keymap.set('n', '<Leader>de', '<Cmd>DBUIFindBuffer<CR>', { desc = 'Find buffer in DBUI' })
      vim.keymap.set('n', '<Leader>dr', '<Cmd>DBUIRefresh<CR>', { desc = 'Refresh DBUI' })

      -- Autocommand to set keymaps ONLY when the DBUI buffer is open
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'dbui',
        callback = function()
          -- Buffer-local keymaps for the DBUI window
          -- vim.keymap.set('n', '<CR>', '<Cmd>DBUIEnter<CR>', { silent = true, buffer = true })
          vim.keymap.set('n', 'gq', '<Cmd>DBUIAddQuery<CR>', { silent = true, buffer = true, desc = 'New Query' })
          -- You could add a map for deleting connections, etc. here
        end,
      })
    end,
  },

  -- Plugin 3: Completion (Optional but recommended)
  -- This depends on the core engine and will be automatically picked up by nvim-cmp
  {
    'kristijanhusak/vim-dadbod-completion',
    dependencies = { 'tpope/vim-dadbod' },
  },
}
