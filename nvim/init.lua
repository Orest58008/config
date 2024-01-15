-- vim: sw=2

-- nvim setup
vim.cmd [[set number]]
vim.cmd [[set sw=4]]

-- keyboard setup
vim.cmd [[set langmap=йцукенгшщзфівапролдячсмитьЙЦУКЕНГШЩЗФІВАПРОЛДЯЧСМИТЬю;qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM.]]

-- packer setup
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- onedark theme
  -- use 'navarasu/onedark.nvim'

  -- catppuccin theme
  -- use { 'catppuccin/nvim', as = "catppuccin" }

  -- fish syntax highlighting
  use 'dag/vim-fish'

  -- ron syntax highlighting
  use 'ron-rs/ron.vim'

  -- toml syntax highlighting
  use 'cespare/vim-toml'
 
  -- lualine
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }
  require('lualine').setup()

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end

end)
