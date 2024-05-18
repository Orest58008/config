--- nvim setup
-- line numbers
vim.opt.number = true
-- proper line breaks
vim.opt.linebreak = true
-- tab width
local tabwidth = 2
vim.opt.sw = tabwidth
vim.opt.ts = tabwidth
vim.opt.et = true -- expand tabs to spaces
-- auto-wrap
local textwidth = 100
vim.opt.tw = textwidth
vim.opt.cc = textwidth
-- clipboard
vim.opt.clipboard = 'unnamedplus'
-- unhighlight search
vim.keymap.set('', '<C-/>', function()
  vim.o.hlsearch = not vim.o.hlsearch
end)

--- lazy.nvim setup
local lazypath = vim.fn.stdpath'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system {
    'git', 'clone', '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require'lazy'.setup {
  { 'jiangmiao/auto-pairs', },
  {
    'kepano/flexoki-neovim',
    config = function()
      vim.cmd('colorscheme flexoki-dark')
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
  },
  {
    'echasnovski/mini.nvim',
    config = function()
      vim.keymap.set('i', '<Tab>',   'pumvisible() ? "\\<C-n>" : "\\<Tab>"',   { expr = true })
      vim.keymap.set('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', { expr = true })

      require'mini.completion'.setup {}
    end,
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      -- list of supported servers:
      --   https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
      local servers = { 'denols', 'ocamllsp' }
      for _, server in ipairs(servers) do
        local server_setup = loadstring ('require"lspconfig".' .. server .. '.setup {}')
        server_setup()
      end
    end,
  },
  {
    'nvim-orgmode/orgmode',
    event = 'VeryLazy',
    ft = { 'org' },
    opts = {
      org_startup_folded = 'content',
      org_hide_leading_stars = true,
    },
  },
  {
    'andweeb/presence.nvim',
    opts = {},
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      defaults = { borderchars = { '-', '|', '-', '|', '*', '*', '*', '*' }, }
    },
    config = function(_, opts)
      require'telescope'.setup(opts)

      vim.keymap.set('n', '<C-o>', vim.cmd('cd/data') and require'telescope.builtin'.find_files)
    end,
  },
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
  },
  { 'andymass/vim-matchup' },
  { 'mhinz/vim-startify' },
}

--- neovide setup
if vim.g.neovide then
  -- fix font height
  vim.opt.guifont = 'monospace,CaskaydiaCove Nerd Font:h11'
  -- remove awful default animations
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_scroll_animation_length = 0
  -- require quit confirmation on unsaved
  vim.g.neovide_confirm_quit = true
end
