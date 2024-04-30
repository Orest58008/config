-- vim: sw=2

-- nvim setup
vim.cmd [[set number]]
vim.cmd [[set sw=4]]

-- lazy.nvim setup
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require'lazy'.setup({
  {
    'nvim-orgmode/orgmode',
    event = 'VeryLazy',
    ft = { 'org' },
    config = function()
      require'orgmode'.setup({
	org_agenda_files = '~/orgfiles/**/*',
	org_default_notes_file = '~/orgfiles/refile.org',
      })
    end,
  },
  { 'jiangmiao/auto-pairs', name = 'auto-pairs' },
  {
    'kepano/flexoki-neovim',
    name = 'flexoki',
    config = function()
      vim.cmd('colorscheme flexoki-dark')
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require'lualine'.setup()
    end,
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      local lc = require'lspconfig'
      lc.denols.setup{}
    end,
  },
  {
    'ervandew/supertab',
    name = 'supertab',
    config = function()
      vim.cmd [[let g:SuperTabDefaultCompletionType = "<c-n>"]]
    end,
  }
})
