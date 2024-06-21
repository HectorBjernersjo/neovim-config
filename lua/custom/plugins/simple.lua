return {
  {
    'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
    { 'numToStr/Comment.nvim', opts = {} },
    { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
  },
}
