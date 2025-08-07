vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.wrap = false
vim.opt.tabstop = 2
vim.opt.swapfile = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.undofile = true
vim.opt.winborder = 'rounded'
vim.g.mapleader = ' '

local keymap = vim.keymap.set

keymap('i', '<C-j>', '<ESC>', { desc = 'Sortir du mode insertion avec CTRL+j.' })

keymap('n', '<leader>nh', ':nohl<CR>', { desc = 'Effacer le surlignage.' })
keymap('n', '<leader>w', ':write<CR>', { desc = 'Sauvegarder le buffer.' })
keymap('n', '<leader>q', ':quit<CR>', { desc = 'Quitter le buffer.' })
keymap('n', '<leader>lf', vim.lsp.buf.format, { desc = 'formatter le code.' })

keymap('n', '<C-y>', '"+y', { noremap = true, silent = true })
keymap('v', '<C-y>', '"+y', { noremap = true, silent = true })
keymap('n', '<C-p>', '"+P', { noremap = true, silent = true })
keymap('v', '<C-p>', '"+P', { noremap = true, silent = true })

vim.pack.add({
	{ src = 'https://github.com/vague2k/vague.nvim' },
	{ src = 'https://github.com/stevearc/oil.nvim' },
	{ src = 'https://github.com/neovim/nvim-lspconfig' },
	{ src = 'https://github.com/mason-org/mason.nvim' },
	{ src = 'https://github.com/echasnovski/mini.pick' },
})

-- COLORSCHEME --

vim.cmd('colorscheme vague')
vim.cmd(':hi StatusLine guibg=NONE')

-- OIL --

require('oil').setup({
	default_file_explorer = true,

	columns = {
		'permissions',
	},
	skip_confirm_for_simple_edits = true,
	view_options = {
		show_hidden = true,
	},
})

keymap('n', '<leader>e', ':Oil<CR>')

-- LSP --

require('mason').setup()

-- lua --
vim.lsp.enable('lua_ls')
vim.lsp.config('lua_ls', {
	settings = {
		Lua = {
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			}
		}
	}
})

-- Pyright
vim.lsp.enable('pyright')

-- PICK --

require('mini.pick').setup()

keymap('n', '<leader>f', ':Pick files<CR>')
keymap('n', '<leader>h', ':Pick help<CR>')
