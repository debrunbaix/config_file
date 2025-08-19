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
	{ src = 'https://github.com/chomosuke/typst-preview.nvim' },
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

-- clangd
vim.lsp.enable('clangd')

-- asm-lsp
vim.lsp.enable('asm-lsp')
vim.lsp.config('asm-lsp', {})

-- typst --
vim.lsp.enable('tinymist')

-- PICK --

require('mini.pick').setup()

keymap('n', '<leader>f', ':Pick files<CR>')
keymap('n', '<leader>h', ':Pick help<CR>')

-- diag
vim.diagnostic.config({
	virtual_test = true,
	signs = true,
	update_in_insert = false,
})

local signs = { Error = "", Warn = "", Hint = "", Info = "" }

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- spell

vim.api.nvim_create_autocmd("Filetype", {
	pattern = "typst",
	callback = function()
		vim.opt.spell = true
		vim.opt.wrap = true
		vim.opt.linebreak = true
		vim.opt.wrapmargin = 10
		vim.cmd([[
				setlocal formatoptions+=1
				setlocal spell spelllang=fr
				]])
		keymap('n', '<leader>p', ':TypstPreview<CR>')
	end,
})
