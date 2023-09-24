-- vim: sw=2

-- nvim setup
vim.cmd [[set number]]
vim.cmd [[set sw=4]]
vim.cmd [[colorscheme catppuccin-mocha]]


-- packer setup
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  
  -- onedark theme
  -- use 'navarasu/onedark.nvim'

  -- catppuccin theme
  use { 'catppuccin/nvim', as = "catppuccin" }

  -- fish syntax highlighting
  use 'dag/vim-fish'

  -- ron syntax highlighting
  use 'ron-rs/ron.vim'

  -- toml syntax highlighting
  use 'cespare/vim-toml'
    
  -- tree-sitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  -- use this command instead for the first build
  --[[
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true})
      ts_update()
    end,
  }
  --]]
  
  -- lualine
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

  -- coc.nvim
  use {'neoclide/coc.nvim', branch = 'release'}

  -- markdown preview
  use({
    'iamcco/markdown-preview.nvim',
    run = function() vim.fn['mkdp#util#install']() end,
  })
end)

-- uncomment this before first using nvim
-- require('packer').sync()


-- coc setup
local keyset = vim.keymap.set
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
keyset('i', '<TAB>', [[coc#pum#visible() ? coc#pum#confirm() : coc#on_enter()]], opts)

-- lightline setup
require('lualine').setup()

-- keyboard setup
vim.cmd [[set langmap=йцукенгшщзфівапролдячсмитьЙЦУКЕНГШЩЗФІВАПРОЛДЯЧСМИТЬю;qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM.]]
