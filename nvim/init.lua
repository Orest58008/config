-- vim: sw=2

-- nvim setup
vim.cmd [[set number]]
vim.cmd [[set shiftwidth=4]]
vim.cmd [[colorscheme catppuccin-macchiato]]


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

  -- barbar bar
  use 'nvim-tree/nvim-web-devicons'
  use 'lewis6991/gitsigns.nvim'
  use 'romgrk/barbar.nvim'

  --coc.nvim
  use {'neoclide/coc.nvim', branch = 'release'}

  --markdown preview
  use({
    'iamcco/markdown-preview.nvim',
    run = function() vim.fn['mkdp#util#install']() end,
  })
end)
-- uncomment this before first using nvim
-- require('packer').sync()


-- plugins setup
local keyset = vim.keymap.set
local opts = {silent = true, noremap = true}

-- coc setup
keyset('i', "<TAB>", [[coc#pum#visible() ? coc#pum#confirm() : coc#on_enter()]], opts)

-- barbar setup
-- Move to previous/next
keyset('n', '<A-Left>', '<Cmd>BufferPrevious<CR>', opts)
keyset('n', '<A-Right>', '<Cmd>BufferNext<CR>', opts)
-- Re-order to previous/next
keyset('n', '<A-S-Left>', '<Cmd>BufferMovePrevious<CR>', opts)
keyset('n', '<A-S-Right>', '<Cmd>BufferMoveNext<CR>', opts)
-- Goto buffer in position...
keyset('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
keyset('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
keyset('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
keyset('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
keyset('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
keyset('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
keyset('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
keyset('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
keyset('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
keyset('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)
-- Pin/unpin buffer
keyset('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)
-- Close buffer
keyset('n', '<A-q>', '<Cmd>BufferClose<CR>', opts)
-- Wipeout buffer
--                 :BufferWipeout
-- Magic buffer-picking mode
keyset('n', '<C-p>', '<Cmd>BufferPick<CR>', opts)
-- Sort automatically by...
keyset('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
keyset('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
keyset('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
keyset('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)

-- FZF setup
keyset('n', '<C-t>', '<Cmd>FZF<CR>', opts)
