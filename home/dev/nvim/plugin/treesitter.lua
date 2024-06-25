require('nvim-treesitter.configs').setup({
	ensure_installed = { 'vim', 'vimdoc', 'lua', 'java' },

	auto_install = true;

	highlight = { enable = true },

	indent = { enable = true },
})

