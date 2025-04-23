--[[=================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||     HECTOR.nvim    ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=================================================================--]]

require("options")
require("keymaps")
require("autocommands")
require("csharp")

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- vim.cmd([[
--   let $LUA_PATH = '/usr/share/lua/5.4/?.lua;/usr/local/share/lua/5.4/?.lua;/usr/local/share/lua/5.4/?/init.lua;/usr/share/lua/5.4/?/init.lua;/usr/local/lib/lua/5.4/?.lua;/usr/local/lib/lua/5.4/?/init.lua;/usr/lib/lua/5.4/?.lua;/usr/lib/lua/5.4/?/init.lua;./?.lua;./?/init.lua;/home/hector/.luarocks/share/lua/5.4/?.lua;/home/hector/.luarocks/share/lua/5.4/?/init.lua'
--   let $LUA_CPATH = '/usr/local/lib/lua/5.4/?.so;/usr/lib/lua/5.4/?.so;/usr/local/lib/lua/5.4/loadall.so;/usr/lib/lua/5.4/loadall.so;./?.so;/home/hector/.luarocks/lib/lua/5.4/?.so' ]])

require("lazy").setup({
  require("colorscheme"),
  -- My own Requirements
  require("custom.lsp.plugins"),
  require("custom.plugins.harpoon"),
  require("custom.plugins.undotree"),
  require("custom.plugins.vimbegood"),
  require("custom.plugins.simple"),
  require("custom.plugins.whichkeys"),
  require("custom.plugins.gitsigns"),
  require("custom.plugins.telescope"),
  -- require("custom.plugins.lspconfig"),
  require("custom.plugins.autoformat"),
  -- require("custom.plugins.autocomplete"),
  -- require("custom.plugins.tokyonight"),
  require("custom.plugins.mini"),
  require("custom.plugins.treesitter"),
  require("custom.plugins.noice"),
  require("custom.plugins.dashboard"),
  -- require("custom.plugins.copilot"),
  require("custom.plugins.vim_tmux_navigator"),
  require("custom.plugins.quarto"),
  require("custom.plugins.oil"),
  require("custom.plugins.vimtex"),
  -- require("custom.plugins.trouble"),
  -- require("custom.plugins.java"),
  require("custom.plugins.magma"),
  -- require("custom.plugins.notebooknavigator"),
  --
  require("kickstart.plugins.debug"),
  require("kickstart.plugins.autopairs"),
  --
  -- require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  -- require 'kickstart.plugins.neo-tree',
  -- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      require = "🌙",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
