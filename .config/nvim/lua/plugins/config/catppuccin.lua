require('catppuccin').setup({
  term_colors = true,
  integrations = {
    neogit = true,
    which_key = true,
    hop = true,
    nvimtree = {
      transparent_panel = true,
    },
  },
})

vim.g.catppuccin_flavour = "frappe" -- latte, frappe, macchiato, mocha

vim.cmd[[colorscheme catppuccin]]
