require('illuminate').configure({
	filetypes_denylist = {
		'NvimTree'
	},
	under_cursor = false,
})

-- catppuccin wipes these?
vim.api.nvim_set_hl(0, 'IlluminatedWordText', { underline = true })
vim.api.nvim_set_hl(0, 'IlluminatedWordRead', { underline = true })
vim.api.nvim_set_hl(0, 'IlluminatedWordWrite', { underline = true })
