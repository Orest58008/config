--- nvim setup
-- line numbers
vim.opt.number = true
-- proper line breaks
vim.opt.linebreak = true
-- tab width
vim.opt.sw = 3
vim.opt.ts = 3
-- clipboard
vim.opt.clipboard = 'unnamedplus'

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
	{
		'jiangmiao/auto-pairs'
	},
	{
		'kepano/flexoki-neovim',
		config = function()
			vim.cmd('colorscheme flexoki-dark')
		end,
	},
	{
		'nvimdev/dashboard-nvim',
		event = 'VimEnter',
		config = function()
			require'dashboard'.setup {
				shortcut_type = 'number',
			}
		end,
		dependencies = { 'nvim-tree/nvim-web-devicons' }
	},
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function()
			require'lualine'.setup()
		end,
	},
	{
		'echasnovski/mini.completion',
		version = '*',
		config = function()
			vim.keymap.set('i', '<Tab>',   [[pumvisible() ? "\<C-n>" : "\<Tab>"]],   { expr = true })
			vim.keymap.set('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true })
			require'mini.completion'.setup {}
		end
	},
	{
		'neovim/nvim-lspconfig',
		config = function()
			local lc = require'lspconfig'
			-- list of supported servers:
			--   https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
			lc.denols.setup {}
		end,
	},
	{
		'nvim-orgmode/orgmode',
		event = 'VeryLazy',
		ft = { 'org' },
		config = function()
			require'orgmode'.setup({
				org_startup_folded = 'content',
				org_hide_leading_stars = true,
			})
		end,
	},
	{
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			local builtin = require'telescope.builtin'
			vim.keymap.set('n', '<C-o>', vim.cmd('cd /data') and builtin.find_files)
		end
	},
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
