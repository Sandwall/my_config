-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.cmd('syntax on')
vim.cmd('filetype plugin indent on')
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.wo.number = true
vim.wo.relativenumber = true
vim.o.tabstop = 2 -- Number of spaces a tab represents
vim.o.shiftwidth = 2 -- Number of spaces for each indentation
vim.o.expandtab = false -- Try to use tabs over spaces
vim.o.autoread = true -- autoread on change
vim.o.smartindent = true -- Automatically indent new lines
vim.o.wrap = false -- Disable line wrapping
vim.o.cursorline = true -- Highlight the current line
vim.o.termguicolors = true -- Enable 24-bit RGB colors

vim.g.clipboard = 'clip'

if vim.g.neovide then
  vim.o.guifont = "Iosevka NFM"
  vim.g.neovide_title_text_color = "pink"
  vim.g.neovide_cursor_animation_length = 0.09
  vim.g.neovide_cursor_trail_size = 0.5
  vim.g.neovide_cursor_smooth_blink = true
  vim.g.neovide_cursor_vfx_mode = "pixiedust"
  vim.keymap.set('n', '<C-s>', ':w<CR>') -- Save
  vim.keymap.set('v', '<C-c>', '"+y') -- Copy
  vim.keymap.set('n', '<C-v>', '"+P') -- Paste normal mode
  vim.keymap.set('v', '<C-v>', '"+P') -- Paste visual mode
  vim.keymap.set('c', '<C-v>', '<C-R>+') -- Paste command mode
  vim.keymap.set('i', '<C-v>', '<ESC>l"+Pli') -- Paste insert mode
end

-- Allow clipboard copy paste in neovim
vim.api.nvim_set_keymap('', '<C-v>', '+p<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('!', '<C-v>', '<C-R>+', { noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<C-v>', '<C-R>+', { noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<C-v>', '<C-R>+', { noremap = true, silent = true})

-- Paragraph navigation, remapping this to be more like Emacs
vim.keymap.set('n', '<C-Up>', '{', { noremap = true })
vim.keymap.set('n', '<C-Down>', '}', { noremap = true })
vim.keymap.set('v', '<C-Up>', '{', { noremap = true })
vim.keymap.set('v', '<C-Down>', '}', { noremap = true })
-- Delete word backward with Ctrl+Backspace in insert mode
vim.keymap.set('i', '<C-BS>', '<C-W>', { noremap = true })
-- Alternative for terminals where C-BS doesn't work properly
vim.keymap.set('i', '<C-H>', '<C-W>', { noremap = true })
-- Delete word forward with Ctrl+Delete in insert mode
vim.keymap.set('i', '<C-Delete>', '<C-O>dw', { noremap = true })

-- Make Ctrl+Left Arrow move to the end of the previous line
-- when cursor is at the beginning of the line (without leaving insert mode)
vim.keymap.set('i', '<C-Left>', function()
  if vim.fn.col('.') == 1 then
    return '<Up><End>'  -- Go up and to end of line without leaving insert mode
  else
    return '<C-Left>'  -- Default behavior: move back one word
  end
end, { noremap = true, expr = true })

vim.keymap.set('n', '<C-Left>', function()
  if vim.fn.col('.') == 1 then
    return 'k$'  -- Go to end of previous line
  else
    return 'b'  -- Default behavior: move back one word
  end
end, { noremap = true, expr = true })

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		{
			'matsuuu/pinkmare',
			lazy = false,
		},
		
		{
			'nvim-lualine/lualine.nvim',
			lazy = false,
			dependencies = { 'nvim-tree/nvim-web-devicons' }
		},
		
		{
			"neovim/nvim-lspconfig", -- REQUIRED: for native Neovim LSP integration
			lazy = false, -- REQUIRED: tell lazy.nvim to start this plugin at startup
			dependencies = {
				{ "ms-jpq/coq_nvim", branch = "coq" },
				{ "ms-jpq/coq.artifacts", branch = "artifacts" },
				
				-- lua & third party sources -- See https://github.com/ms-jpq/coq.thirdparty
				-- Need to **configure separately**
				{ 'ms-jpq/coq.thirdparty', branch = "3p" }
			},
			init = function()
				vim.g.coq_settings = {
					auto_start = true, -- if you want to start COQ at startup
					-- Your COQ settings here
				}
			end,
			config = function()
				-- Your LSP settings here
			end,
		},
		
		{
			"nvim-treesitter/nvim-treesitter",
			build = ":TSUpdate",
		}
	},
	
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "pinkmare" } },
	
	-- automatically check for plugin updates
	checker = { enabled = true },
})

vim.cmd("colorscheme pinkmare")

require('lualine').setup ({
	options = {
		section_separators = { left = '', right = '' },
		component_separators = { left = '', right = '' },
		theme = "wombat"
	},
})

local coq = require("coq")

vim.lsp.enable('clangd')
vim.lsp.config('clangd', {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=never",
    "--completion-style=detailed",
  },
  filetypes = { "c", "cpp", "h", "hpp", "ixx", "objc", "objcpp", "cuda" },
  init_options = {
    usePlaceholders = true,
    completeUnimported = true,
    clangdFileStatus = true,
  },

})

vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', 'K', vim.lsp.buf.hover)
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action)

vim.g.nvim_treesitter_cpp_compiler = "clang"

require('nvim-treesitter.configs').setup({
	ensure_installed = {
		"lua", 
		"vim",
		"python",
		"cpp",
		"c"
	},
	highlight = {
		enable = true,
	},
	indent = {
		enable = true,
	},
})
