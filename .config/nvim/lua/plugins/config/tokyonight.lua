vim.g.tokyonight_sidebars = { "quickfix", "__vista__", "term", "fzf", "fugitive" }
vim.g.tokyonight_italic_keywords = false
--vim.g.tokyonight_hide_inactive_statusline = true
vim.g.tokyonight_dark_sidebar = false
vim.g.tokyonight_style = "storm"

-- needs to happen after config is set
vim.cmd 'colorscheme tokyonight'
