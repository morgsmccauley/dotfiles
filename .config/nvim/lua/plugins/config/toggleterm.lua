require'toggleterm'.setup {
  shade_terminals = false,
  direction = 'vertical',
  open_mapping = [[<C-t>]],
  start_in_insert = true,
  persist_size = false,
  size = function()
    return vim.o.columns * 0.5
  end,
  on_open = function(t)
    vim.wo.winfixwidth = false

    vim.api.nvim_buf_set_keymap(t.bufnr, 't', '<C-h>', [[<C-\><C-n><C-W><C-h>]], { noremap = true })
    vim.api.nvim_buf_set_keymap(t.bufnr, 't', '<C-\\>', [[<C-\><C-n>]], { noremap = true })
    vim.api.nvim_buf_set_keymap(t.bufnr, 't', '<C-j>', [[<C-\><C-n><C-W><C-j>]], { noremap = true })
    vim.api.nvim_buf_set_keymap(t.bufnr, 't', '<C-k>', [[<C-\><C-n><C-W><C-k>]], { noremap = true })
    vim.api.nvim_buf_set_keymap(t.bufnr, 't', '<C-x>', [[<C-\><C-n>:q!<Cr>]], { noremap = true })

    vim.api.nvim_buf_set_keymap(t.bufnr, 't', '<C-n>', [[<C-\><C-n>:NvimTreeToggle<Cr>]], { noremap = true })
  end,
}
