-- | OPTIONS | --
vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.clipboard = "unnamedplus"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.wrap = false
vim.opt.signcolumn = "yes"
vim.opt.completeopt = { 'menuone', 'noinsert', 'noselect' }
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

-- | PLUGINS | --
vim.pack.add({
  'https://github.com/nyoom-engineering/oxocarbon.nvim',
  'https://github.com/datsfilipe/vesper.nvim',
  'https://github.com/stevearc/oil.nvim',
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/echasnovski/mini.pairs',
})

-- | THEME | --
vim.cmd.colorscheme('vesper')

vim.api.nvim_set_hl(0, 'FloatBorder', { fg = '#78938a' })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#1a1a1a' })

-- | OIL | --
require('oil').setup({
  columns = { "icon", "permissions" },
  view_options = { show_hidden = true },
  skip_confirm_for_simple_edits = true,
  lsp_file_methods = { autosave_changes = true },
})
vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>", { desc = "Ouvrir Oil" })

-- | AUTO-PAIRS | --
local pairs_ok, mini_pairs = pcall(require, 'mini.pairs')
if pairs_ok then
  mini_pairs.setup()
end

-- | TREESITTER | --
local ts_ok, ts_configs = pcall(require, 'nvim-treesitter.configs')
if ts_ok then
  ts_configs.setup({
    ensure_installed = { 'python', 'lua', 'rust', 'c', 'json', 'toml', 'markdown' },
    highlight = { enable = true },
    indent = { enable = true },
  })
end

-- | LSP | --
vim.diagnostic.config({
  float = { border = 'rounded' },
  virtual_lines = { current_line = true },
  underline = true,
  signs = true,
})

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      diagnostics = { globals = { 'vim' } },
      telemetry = { enable = false },
      workspace = {
        checkThirdParty = false,
        library = { vim.env.VIMRUNTIME },
      },
    },
  },
})

vim.lsp.config('basedpyright', {
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = 'basic',
        autoImportCompletions = true,
      },
    },
  },
})

vim.lsp.config('rust_analyzer', {
  settings = {
    ['rust-analyzer'] = {
      checkOnSave = true,
      check = { command = 'clippy' },
      cargo = { allFeatures = true },
    },
  },
})

vim.lsp.enable('rust_analyzer')
vim.lsp.enable('basedpyright')
vim.lsp.enable('clangd')
vim.lsp.enable('jsonls')
vim.lsp.enable('tinymist')
vim.lsp.enable('lua_ls')

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local opts = { buffer = args.buf }
    vim.keymap.set('n', 'gd',         vim.lsp.buf.definition,     opts)
    vim.keymap.set('n', 'gD',         vim.lsp.buf.declaration,    opts)
    vim.keymap.set('n', 'gr',         vim.lsp.buf.references,     opts)
    vim.keymap.set('n', 'gi',         vim.lsp.buf.implementation, opts)
    -- vim.keymap.set('n', 'K',          vim.lsp.buf.hover,          opts)
    vim.keymap.set('n', 'K', function()
      vim.lsp.buf.hover({ border = 'rounded' })
    end, { desc = 'LSP Hover' })
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename,         opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action,    opts)
    vim.keymap.set('n', '<leader>f',  vim.lsp.buf.format,         opts)
    vim.keymap.set('n', '<leader>d',  vim.diagnostic.open_float,  opts)
    vim.keymap.set('n', '[d',         vim.diagnostic.goto_prev,   opts)
    vim.keymap.set('n', ']d',         vim.diagnostic.goto_next,   opts)

    -- bordure sur le hover
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client then
      vim.lsp.handlers['textDocument/hover'] = function(err, result, ctx)
        return vim.lsp.handlers.hover(err, result, ctx, { border = 'rounded' })
      end

      -- completion LSP native (Neovim 0.11+)
      if client:supports_method('textDocument/completion') then
        vim.lsp.completion.enable(true, args.data.client_id, args.buf, { autotrigger = true })
      end
    end
  end,
})

-- Entrée confirme la sélection, tab/shift-tab naviguent
vim.keymap.set('i', '<Tab>',   function() return vim.fn.pumvisible() == 1 and '<C-n>' or '<Tab>'   end, { expr = true })
vim.keymap.set('i', '<S-Tab>', function() return vim.fn.pumvisible() == 1 and '<C-p>' or '<S-Tab>' end, { expr = true })
vim.keymap.set('i', '<CR>',    function() return vim.fn.pumvisible() == 1 and '<C-y>' or '<CR>'    end, { expr = true })

-- init main c --
vim.keymap.set('n', '<leader>cm', function()
  local lines = {
    '#include <stdio.h>',
    '',
    '#define SUCCESS 0',
    '#define ERROR -1',
    '',
    'int main(int argc, char *argv[])',
    '{',
    '   return SUCCESS;',
    '}',
  }
  vim.api.nvim_put(lines, 'l', true, true)
end, { noremap = true, desc = 'Insert C main template' })
