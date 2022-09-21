require('catppuccin').setup({
  term_colors = true,
  compile = {
    enabled = true,
    path = vim.fn.stdpath "cache" .. "/catppuccin"
  },
  integrations = {
    neogit = true,
    which_key = true,
    hop = true,
    nvimtree = {
      transparent_panel = true,
    },
  },
})

vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha

vim.cmd [[colorscheme catppuccin]]
