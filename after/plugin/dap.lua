local dap = require('dap')

-- Initialize dap.configurations.python as an empty table
dap.configurations.python = {}

-- Insert the external terminal configuration
table.insert(dap.configurations.python, {
  type = 'python',
  request = 'launch',
  name = 'Launch file in externalTerminal',
  program = '${file}',
  console = 'integratedTerminal';
  justMyCode = true,  -- Enable or disable just my code debugging
  redirectOutput = true,
  exception = {
      raise = {action = "stop"},  -- Stop on raised exceptions
      uncaught = {action = "stop"},  -- Stop on uncaught exceptions
  },
})

-- Further Python configuration for the adapter
dap.adapters.python = {
  type = 'executable';
  -- command = os.getenv('HOME') .. '/.virtualenvs/debugpy/bin/python';
    command = 'python3',
  args = { '-m', 'debugpy.adapter' };
}
vim.api.nvim_set_keymap('n', '<F5>', "<cmd>lua require('dap').continue(); require('dapui').open()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<F4>', "<cmd>lua require('dapui').toggle()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<F10>', "<cmd>lua require('dap').step_over()<CR>", {noremap = true})
vim.api.nvim_set_keymap('n', '<F11>', "<cmd>lua require('dap').step_into()<CR>", {noremap = true})
vim.api.nvim_set_keymap('n', '<F12>', "<cmd>lua require('dap').step_out()<CR>", {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>b', "<cmd>lua require('dap').toggle_breakpoint()<CR>", {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>B', "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>lp', "<cmd>lua require('dap').run_last()<CR>", {noremap = true})

require('dapui').setup({
  layouts = {
    {
      elements = {
        "scopes",
        "stacks",
        "watches",
        "repl",
        -- Exclude breakpoints and [dap-repl] by not listing them here
      },
      size = 40, -- Adjust size as needed
      position = "right", -- Can be "left", "right", "top", "bottom"
    },
    {
      elements = {
        "console", -- Include the integrated terminal
      },
      size = 10, -- Adjust size for the terminal as needed
      position = "bottom", -- Position of the terminal
    },
  },
  -- Other configuration options...
})

